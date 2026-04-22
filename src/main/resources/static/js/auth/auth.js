async function checkLoginState() {
    const sessionData = sessionStorage.getItem('cyber_user');
    const localData = localStorage.getItem('cyber_user');
    const savedUser = sessionData || localData;
    if (!savedUser) return;

    const user = JSON.parse(savedUser);
    applyLoginState(user); // Apply immediately with cached data

    // Then fetch fresh coin balance from server
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!token) return;
    try {
        const res = await fetch(`${API_BASE_URL}/team/members/${user.id}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return;
        const fresh = await res.json();
        let changed = false;
        if (fresh.coin !== undefined && fresh.coin !== user.coin)         { user.coin = fresh.coin; changed = true; }
        if (fresh.isMentor !== undefined && fresh.isMentor !== user.isMentor) { user.isMentor = fresh.isMentor; changed = true; }
        if (changed) {
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(user));
            applyLoginState(user);
        }
    } catch { /* server unavailable, keep cached value */ }
}

function applyLoginState(userData) {
    isLoggedIn = true;
    const navGuest = document.getElementById('nav-guest');
    const navUser = document.getElementById('nav-user');
    
    if (navGuest) { navGuest.classList.add('hidden'); navGuest.classList.remove('flex'); }
    if (navUser) {
        navUser.classList.remove('hidden'); navUser.classList.add('flex');
        
        const nameSpan = navUser.querySelector('span.truncate'); 
        if (nameSpan) nameSpan.textContent = userData.name;
        
        const coinDisplay = document.getElementById('nav-coin-display');
        if (coinDisplay) {
            const currentText = coinDisplay.textContent;
            const startCoin = parseInt(currentText.replace(/,/g, '')) || 0;
            const endCoin = userData.coin || 0;
            if (startCoin !== endCoin) animateCoinValue('nav-coin-display', startCoin, endCoin, 1500); 
            else coinDisplay.textContent = endCoin.toLocaleString(); 
        }

        const avatarDiv = navUser.querySelector('.w-7.h-7');
        if (avatarDiv) {
            const initials = userData.name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();
            avatarDiv.innerHTML = `<span class="text-black font-bold text-[10px] font-mono">${initials}</span>`;
        }

        // Change "Join the Club" to "My Dashboard" when logged in
        const joinBtn = document.getElementById('home-join-btn');
        if (joinBtn) {
            joinBtn.textContent = 'My Profile';
            joinBtn.onclick = () => showPage('my-profile');
        }

        // Show Mentor Hub link and role badge based on isMentor flag
        const mentorHubLink = document.getElementById('nav-mentor-hub-link');
        if (mentorHubLink) mentorHubLink.classList.toggle('hidden', !userData.isMentor);

        const roleBadge = document.getElementById('nav-role-badge');
        if (roleBadge) {
            if (userData.isMentor) {
                roleBadge.textContent = 'MENTOR';
                roleBadge.className = 'font-mono text-[9px] font-bold tracking-widest px-1.5 py-0.5 border text-tertiary border-tertiary/50';
            } else {
                roleBadge.textContent = 'MENTEE';
                roleBadge.className = 'font-mono text-[9px] font-bold tracking-widest px-1.5 py-0.5 border text-secondary border-secondary/50';
            }
        }

        // Show add buttons now that user is logged in
        const projectBtn = document.getElementById('create-project-btn');
        if (projectBtn) projectBtn.classList.replace('hidden', 'flex');
        const pubBtn = document.getElementById('create-publication-btn');
        if (pubBtn) pubBtn.classList.replace('hidden', 'flex');

        // Hide the "Join CyberTitans Today" CTA when already logged in
        const ctaJoin = document.getElementById('cta-join-section');
        if (ctaJoin) ctaJoin.style.display = 'none';
    }
}

async function doLogin() {
    const userEl = document.getElementById('login-user');
    const passEl = document.getElementById('login-pass');
    const keepPersistentEl = document.getElementById('keep-persistent');
    
    if (!userEl.value || !passEl.value) return showToast('Please fill in all fields!', 'error');

    try {
        const response = await fetch(`${API_BASE_URL}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username: userEl.value, password: passEl.value })
        });

        if (response.ok) {
            const userData = await response.json();
            localStorage.removeItem('cyber_user'); localStorage.removeItem('cyber_token');
            sessionStorage.removeItem('cyber_user'); sessionStorage.removeItem('cyber_token');

            const storage = keepPersistentEl && keepPersistentEl.checked ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(userData));
            storage.setItem('cyber_token', userData.token); 
            
            closeModal('login-modal'); applyLoginState(userData);
            showToast(`ACCESS GRANTED. Welcome, ${userData.name}!`, 'success');
            const _today = new Date().toDateString();
            const _lastBonus = localStorage.getItem('last_daily_bonus');
            if (_lastBonus !== _today) {
                localStorage.setItem('last_daily_bonus', _today);
                await _addCoinsToSelf(20, 'daily login');
            }
            userEl.value = ''; passEl.value = '';
        } else { showToast('ACCESS DENIED: Invalid credentials.', 'error'); }
    } catch (err) { showToast('SERVER ERROR: Connection failed.', 'error'); }
}

function logout() {
    localStorage.removeItem('cyber_user'); localStorage.removeItem('cyber_token');
    sessionStorage.removeItem('cyber_user'); sessionStorage.removeItem('cyber_token');
    isLoggedIn = false;

    const navGuest = document.getElementById('nav-guest');
    const navUser = document.getElementById('nav-user');
    if (navGuest) navGuest.classList.replace('hidden', 'flex');
    if (navUser) navUser.classList.replace('flex', 'hidden');

    const joinBtn = document.getElementById('home-join-btn');
    if (joinBtn) {
        joinBtn.textContent = 'Join the Club';
        joinBtn.onclick = () => openModal('login-modal');
    }

    showPage('home'); showToast('DISCONNECTED.', 'success');
}