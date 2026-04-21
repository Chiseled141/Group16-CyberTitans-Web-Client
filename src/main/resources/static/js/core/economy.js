async function purchaseTier(tierName, coinsAmount) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');

    if (!savedUserStr || !token) {
        showToast('Please log in first.', 'error');
        openModal('login-modal'); return;
    }

    const currentUser = JSON.parse(savedUserStr);

    if (coinsAmount === 0) {
        showToast(`You are already on the ${tierName} tier.`, 'success');
        return;
    }

    const currentCoins = currentUser.coin || 0;
    if (currentCoins < coinsAmount) {
        showToast(`Insufficient Coins. Need ${coinsAmount.toLocaleString()}, have ${currentCoins.toLocaleString()}.`, 'error');
        return;
    }

    const newCoinBalance = currentCoins - coinsAmount;
    const payload = { coin: newCoinBalance };

    try {
        showToast('Processing transaction...', 'success');
        const response = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify(payload)
        });

        if (response.ok) {
            currentUser.coin = newCoinBalance;
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(currentUser));
            showToast(`✓ ${tierName} tier unlocked! −${coinsAmount.toLocaleString()} Coins.`, 'success');
            applyLoginState(currentUser);
        } else {
            showToast('Transaction denied.', 'error');
        }
    } catch (error) {
        showToast('Connection failed.', 'error');
    }
}

async function handleMentorRequest(mentorId, mentorName) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');

    if (!savedUserStr || !token) return showToast('Please log in first.', 'error');

    const currentUser = JSON.parse(savedUserStr);
    const MENTOR_COST = 500;

    if ((currentUser.coin || 0) < MENTOR_COST) {
        showToast(`Insufficient Coins. Need ${MENTOR_COST}, have ${currentUser.coin || 0}.`, 'error');
        return;
    }

    const msgEl = document.getElementById(`mentor-msg-${mentorId}`);
    const message = msgEl ? msgEl.value.trim() : '';

    try {
        const res = await fetch(`${API_BASE_URL}/mentor/requests`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ mentorId, message })
        });

        if (!res.ok) {
            showToast('Failed to send request. Please try again.', 'error');
            return;
        }

        // Deduct coins after confirmed request
        const newCoinBalance = (currentUser.coin || 0) - MENTOR_COST;
        await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ coin: newCoinBalance })
        });

        currentUser.coin = newCoinBalance;
        const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
        storage.setItem('cyber_user', JSON.stringify(currentUser));
        applyLoginState(currentUser);
        showToast(`Request sent to ${mentorName}! −${MENTOR_COST} Coins.`, 'success');

        const form = document.getElementById(`mentor-request-form-${mentorId}`);
        if (form) {
            form.innerHTML = `<div class="w-full bg-yellow-500/10 border border-yellow-500/30 text-yellow-400 font-bold font-mono tracking-widest py-3.5 text-[11px] mb-2 text-center cursor-not-allowed">● REQUEST PENDING</div>`;
        }
    } catch {
        showToast('Connection failed.', 'error');
    }
}

// UC008 — Check for pending mentorship request (DB-backed)
async function getMyPendingRequest(mentorId) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return null;

    try {
        const res = await fetch(`${API_BASE_URL}/mentor/my-requests`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return null;
        const requests = await res.json();
        const currentUser = JSON.parse(savedUserStr);
        return requests.find(r => r.mentorId === mentorId && r.menteeId === currentUser.id && r.status === 'PENDING') || null;
    } catch { return null; }
}

// ── Admin: Award coins to any member ────────────────────────────────────────

function openAwardCoinsModal(userId, userName) {
    document.getElementById('award-coins-user-id').value = userId;
    document.getElementById('award-coins-target-name').textContent = `Target: ${userName}`;
    document.getElementById('award-coins-amount').value = '';
    openModal('award-coins-modal');
}

async function submitAwardCoins() {
    const userId = parseInt(document.getElementById('award-coins-user-id').value);
    const amount = parseInt(document.getElementById('award-coins-amount').value);
    if (!userId || isNaN(amount) || amount <= 0) { showToast('Enter a valid amount', 'error'); return; }

    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!token) { showToast('Not authenticated', 'error'); return; }
    try {
        const res = await fetch(`${API_BASE_URL}/team/members/${userId}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) throw new Error();
        const member = await res.json();
        const newBalance = (member.coin || 0) + amount;

        const update = await fetch(`${API_BASE_URL}/team/members/${userId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ coin: newBalance })
        });
        if (!update.ok) throw new Error();
        closeModal('award-coins-modal');
        showToast(`+${amount} Coins awarded to ${member.name}!`, 'success');
    } catch {
        showToast('Failed to award coins', 'error');
    }
}

// ── Auto-reward: add coins to the currently logged-in user ──────────────────

async function _addCoinsToSelf(amount, reason) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return;
    const currentUser = JSON.parse(savedUserStr);
    const newBalance = Math.max(0, (currentUser.coin || 0) + amount);
    try {
        const res = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ coin: newBalance })
        });
        if (res.ok) {
            currentUser.coin = newBalance;
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(currentUser));
            applyLoginState(currentUser);
            if (amount > 0) showToast(`+${amount} Coins earned for ${reason}!`, 'success');
        }
    } catch { /* silent — reward is best-effort */ }
}

async function cancelMentorRequest(mentorId) {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!token) return;

    try {
        const res = await fetch(`${API_BASE_URL}/mentor/my-requests`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return;
        const requests = await res.json();
        const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
        if (!savedUserStr) return;
        const currentUser = JSON.parse(savedUserStr);
        const pending = requests.find(r => r.mentorId === mentorId && r.menteeId === currentUser.id && r.status === 'PENDING');
        if (!pending) return;

        await fetch(`${API_BASE_URL}/mentor/requests/${pending.id}/cancel`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        showToast('Mentorship request cancelled.', 'success');
        openProfileModal(mentorId);
    } catch {
        showToast('Failed to cancel request.', 'error');
    }
}