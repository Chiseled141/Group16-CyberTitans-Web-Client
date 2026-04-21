// ─── MENTOR HUB ─────────────────────────────────────────────────────────────
// UC014 Approve Mentorship Request
// UC015 Decline Mentorship Request
// UC018 Guide Project Members
// UC019 View Assigned Mentees

let _cachedRequests = null;

async function _fetchRequests() {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!token) return [];
    try {
        const res = await fetch(`${API_BASE_URL}/mentor/requests`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return [];
        _cachedRequests = await res.json();
        return _cachedRequests;
    } catch { return []; }
}

function _getGuidance() {
    try { return JSON.parse(localStorage.getItem('mentor_guidance') || '[]'); } catch { return []; }
}

async function buildMentorHub() {
    await _updateInboxBadge();
    showMentorHubTab('inbox');
}

async function showMentorHubTab(tab) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return;
    const currentUser = JSON.parse(savedUserStr);

    ['inbox', 'assigned', 'guide', 'skills'].forEach(t => {
        const btn = document.getElementById('tab-' + t);
        if (!btn) return;
        if (t === tab) {
            btn.classList.add('border-primary', 'text-primary');
            btn.classList.remove('border-transparent', 'text-gray-500');
        } else {
            btn.classList.remove('border-primary', 'text-primary');
            btn.classList.add('border-transparent', 'text-gray-500');
        }
    });

    const content = document.getElementById('mentor-hub-content');
    if (!content) return;

    const requests = _cachedRequests || await _fetchRequests();
    // GET /mentor/requests already filters server-side for the logged-in mentor's team
    const mine = requests;

    if (tab === 'inbox') {
        const pending = mine.filter(r => r.status === 'PENDING');
        if (!pending.length) {
            content.innerHTML = `<div class="text-center py-20 font-mono text-gray-500 text-xs uppercase tracking-widest">[ No pending requests ]</div>`;
            return;
        }
        content.innerHTML = pending.map(r => `
            <div class="bg-[#0a0a0a] border border-white/5 hover:border-primary/20 p-6 transition-all">
                <div class="flex items-start justify-between gap-4 flex-wrap">
                    <div>
                        <div class="flex items-center gap-2 mb-2">
                            <span class="font-mono text-[9px] uppercase tracking-widest text-yellow-400 border border-yellow-400/30 px-2 py-0.5 bg-yellow-400/5">PENDING</span>
                            <span class="font-mono text-[10px] text-gray-500">${new Date(r.createdAt).toLocaleDateString('en-GB', {day:'2-digit',month:'short',year:'numeric'})}</span>
                        </div>
                        <p class="text-white font-bold text-lg font-headline">${r.menteeName}</p>
                        <p class="font-mono text-xs text-gray-500 mt-0.5">Mentee ID: #${String(r.menteeId).padStart(4, '0')}</p>
                    </div>
                    <div class="flex gap-2 flex-shrink-0">
                        <button onclick="approveRequest('${r.id}')"
                            class="px-5 py-2.5 bg-primary text-black text-[10px] font-bold uppercase tracking-widest hover:brightness-110 transition-all flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-[14px]">check</span> ACCEPT
                        </button>
                        <button onclick="declineRequest('${r.id}')"
                            class="px-5 py-2.5 bg-red-600/20 border border-red-500/50 text-red-400 text-[10px] font-bold uppercase tracking-widest hover:bg-red-600 hover:text-white transition-all flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-[14px]">close</span> DECLINE
                        </button>
                    </div>
                </div>
            </div>`).join('');

    } else if (tab === 'assigned') {
        const accepted = mine.filter(r => r.status === 'ACCEPTED');
        if (!accepted.length) {
            content.innerHTML = `<div class="text-center py-20 font-mono text-gray-500 text-xs uppercase tracking-widest">[ No assigned mentees yet ]</div>`;
            return;
        }
        content.innerHTML = accepted.map(r => `
            <div class="bg-[#0a0a0a] border border-white/5 hover:border-primary/20 p-6 transition-all">
                <div class="flex items-center justify-between gap-4 flex-wrap">
                    <div>
                        <span class="font-mono text-[9px] uppercase tracking-widest text-primary border border-primary/30 px-2 py-0.5 bg-primary/5">ACTIVE</span>
                        <p class="text-white font-bold text-lg font-headline mt-2">${r.menteeName}</p>
                        <p class="font-mono text-xs text-gray-500 mt-0.5">Since ${new Date(r.createdAt).toLocaleDateString('en-GB', {day:'2-digit',month:'short',year:'numeric'})}</p>
                    </div>
                    <button onclick="openGuideForm('${r.menteeId}')"
                        class="px-5 py-2.5 border border-primary/30 text-primary text-[10px] font-mono uppercase tracking-widest hover:bg-primary hover:text-black transition-all flex items-center gap-1.5">
                        <span class="material-symbols-outlined text-[14px]">edit_note</span> GUIDE
                    </button>
                </div>
            </div>`).join('');

    } else if (tab === 'skills') {
        const currentSkills = (currentUser.experiences || []).map(e => e.name).filter(Boolean);
        const skillChips = currentSkills.length
            ? currentSkills.map(s => `
                <span class="inline-flex items-center gap-1.5 tag-primary pf-skill-tag">
                    ${s}
                    <button onclick="removeMentorSkill('${s}')" class="text-primary hover:text-red-400 transition-colors leading-none">&times;</button>
                </span>`).join('')
            : '<p class="font-mono text-xs text-gray-500 italic">No skills listed yet.</p>';

        content.innerHTML = `
            <div class="max-w-xl">
                <h3 class="font-headline text-sm font-bold uppercase tracking-widest mb-5 text-white flex items-center gap-3">
                    <span class="w-2 h-2 bg-primary"></span>Update Mentor Skills
                </h3>
                <p class="font-mono text-xs text-gray-500 mb-6 leading-relaxed">These skills are shown on your mentor card and help mentees find you. Add skills that match your expertise.</p>
                <div class="mb-6">
                    <label class="font-mono text-[10px] uppercase tracking-widest text-gray-500 block mb-3">Current Skills</label>
                    <div id="mentor-skill-chips" class="flex flex-wrap gap-2 min-h-[40px]">${skillChips}</div>
                </div>
                <div class="flex gap-3 mb-6">
                    <input id="mentor-skill-input" type="text" placeholder="e.g. Spring Boot, Docker, Python..."
                        class="flex-1 bg-[#0a0a0a] border border-white/10 text-white font-mono text-sm p-3 focus:border-primary outline-none placeholder:text-gray-600"
                        onkeydown="if(event.key==='Enter'){addMentorSkill();event.preventDefault();}"/>
                    <button onclick="addMentorSkill()"
                        class="px-5 py-3 bg-primary text-black font-bold font-mono text-[10px] uppercase tracking-widest hover:brightness-110 transition-all">
                        ADD
                    </button>
                </div>
                <button onclick="saveMentorSkills()"
                    class="w-full py-3.5 border border-primary text-primary font-bold font-mono text-[10px] uppercase tracking-widest hover:bg-primary hover:text-black transition-all flex items-center justify-center gap-2">
                    <span class="material-symbols-outlined text-[14px]">save</span> SAVE SKILLS
                </button>
            </div>`;
        return;

    } else if (tab === 'guide') {
        const accepted = mine.filter(r => r.status === 'ACCEPTED');
        const guidance = _getGuidance().filter(g => g.mentorId === currentUser.id);

        const menteeOptions = accepted.length
            ? accepted.map(r => `<option value="${r.menteeId}" data-name="${r.menteeName}">${r.menteeName}</option>`).join('')
            : '<option disabled>No assigned mentees yet</option>';

        const guidanceLog = guidance.length
            ? guidance.map(g => `
                <div class="border border-white/5 bg-[#0a0a0a] p-4 hover:border-primary/10 transition-all">
                    <div class="flex items-center justify-between mb-2">
                        <span class="font-mono text-[10px] text-primary uppercase">${g.menteeName}</span>
                        <span class="font-mono text-[9px] text-gray-500">${new Date(g.timestamp).toLocaleDateString('en-GB',{day:'2-digit',month:'short',year:'numeric'})}</span>
                    </div>
                    <p class="font-mono text-xs text-gray-400 leading-relaxed">${g.content}</p>
                </div>`).join('')
            : '<p class="font-mono text-xs text-gray-500 text-center py-6">No guidance on record yet.</p>';

        content.innerHTML = `
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <div>
                    <h3 class="font-headline text-sm font-bold uppercase tracking-widest mb-5 text-white flex items-center gap-3">
                        <span class="w-2 h-2 bg-primary"></span>Send Guidance
                    </h3>
                    <div class="space-y-4">
                        <div>
                            <label class="font-mono text-[10px] uppercase tracking-widest text-gray-500 block mb-2">Select Mentee</label>
                            <select id="guide-mentee-select" class="w-full bg-[#0a0a0a] border border-white/10 text-white font-mono text-sm p-3 focus:border-primary outline-none">
                                <option value="">— Select operative —</option>
                                ${menteeOptions}
                            </select>
                        </div>
                        <div>
                            <label class="font-mono text-[10px] uppercase tracking-widest text-gray-500 block mb-2">Guidance Message</label>
                            <textarea id="guide-content" rows="6"
                                placeholder="Write guidance, feedback, or tasks for your mentee..."
                                class="w-full bg-[#0a0a0a] border border-white/10 text-white font-mono text-sm p-3 focus:border-primary outline-none resize-none placeholder:text-gray-600 leading-relaxed"></textarea>
                        </div>
                        <button onclick="submitGuidance()"
                            class="w-full py-3.5 bg-primary text-black font-bold font-mono text-[10px] uppercase tracking-widest hover:brightness-110 transition-all flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined text-[14px]">send</span> TRANSMIT GUIDANCE
                        </button>
                    </div>
                </div>
                <div>
                    <h3 class="font-headline text-sm font-bold uppercase tracking-widest mb-5 text-white flex items-center gap-3">
                        <span class="w-2 h-2 bg-secondary"></span>Guidance Log
                    </h3>
                    <div class="space-y-3 max-h-[500px] overflow-y-auto hide-scrollbar">${guidanceLog}</div>
                </div>
            </div>`;
    }
}

async function approveRequest(reqId) {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    try {
        await fetch(`${API_BASE_URL}/mentor/requests/${reqId}/accept`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const req = (_cachedRequests || []).find(r => String(r.id) === String(reqId));
        const name = req ? req.menteeName : 'Mentee';
        _cachedRequests = null;
        showToast(`${name} accepted as mentee!`, 'success');
        await _addCoinsToSelf(100, 'accepting a mentee');
        await _updateInboxBadge();
        showMentorHubTab('inbox');
    } catch { showToast('Failed to accept request', 'error'); }
}

async function declineRequest(reqId) {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    try {
        await fetch(`${API_BASE_URL}/mentor/requests/${reqId}/decline`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const req = (_cachedRequests || []).find(r => String(r.id) === String(reqId));
        const name = req ? req.menteeName : 'Mentee';
        _cachedRequests = null;
        await _addCoinsToSelf(-50, 'declining a mentee request');
        showToast(`Request from ${name} declined. −50 Coins.`, 'success');
        await _updateInboxBadge();
        showMentorHubTab('inbox');
    } catch { showToast('Failed to decline request', 'error'); }
}

function openGuideForm(menteeId) {
    showMentorHubTab('guide');
    setTimeout(() => {
        const sel = document.getElementById('guide-mentee-select');
        if (sel) sel.value = menteeId;
    }, 50);
}

function submitGuidance() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return;
    const currentUser = JSON.parse(savedUserStr);

    const sel = document.getElementById('guide-mentee-select');
    const textarea = document.getElementById('guide-content');

    if (!sel || !sel.value) return showToast('Select a mentee first.', 'error');
    if (!textarea || !textarea.value.trim()) return showToast('Guidance message cannot be empty.', 'error');

    const menteeName = sel.options[sel.selectedIndex].dataset.name || sel.options[sel.selectedIndex].text;

    const guidance = _getGuidance();
    guidance.unshift({
        mentorId: currentUser.id,
        menteeId: parseInt(sel.value),
        menteeName,
        content: textarea.value.trim(),
        timestamp: new Date().toISOString()
    });
    localStorage.setItem('mentor_guidance', JSON.stringify(guidance));

    textarea.value = '';
    showToast('Guidance transmitted!', 'success');
    showMentorHubTab('guide');
}

function _getMentorSkills() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return [];
    const u = JSON.parse(savedUserStr);
    return (u.experiences || []).map(e => e.name).filter(Boolean);
}

function addMentorSkill() {
    const input = document.getElementById('mentor-skill-input');
    if (!input || !input.value.trim()) return;
    const skill = input.value.trim();
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return;
    const u = JSON.parse(savedUserStr);
    const skills = (u.experiences || []).map(e => e.name).filter(Boolean);
    if (skills.includes(skill)) { showToast('Skill already added', 'error'); return; }
    skills.push(skill);
    u.experiences = skills.map(s => ({ name: s }));
    const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
    storage.setItem('cyber_user', JSON.stringify(u));
    input.value = '';
    showMentorHubTab('skills');
}

function removeMentorSkill(skill) {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return;
    const u = JSON.parse(savedUserStr);
    u.experiences = (u.experiences || []).filter(e => e.name !== skill);
    const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
    storage.setItem('cyber_user', JSON.stringify(u));
    showMentorHubTab('skills');
}

async function saveMentorSkills() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return showToast('Session expired. Please log in again.', 'error');
    const u = JSON.parse(savedUserStr);
    try {
        const res = await fetch(`${API_BASE_URL}/team/members/${u.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ name: u.name, email: u.email, experiences: u.experiences || [] })
        });
        if (res.ok) showToast('Skills updated successfully!', 'success');
        else showToast('Skills saved locally.', 'success');
    } catch { showToast('Skills saved locally.', 'success'); }
}

async function _updateInboxBadge() {
    const requests = await _fetchRequests();
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const currentUser = savedUserStr ? JSON.parse(savedUserStr) : null;
    const count = requests.filter(r => r.status === 'PENDING').length;
    const badge = document.getElementById('mentor-inbox-badge');
    if (!badge) return;
    badge.textContent = count;
    badge.classList.toggle('hidden', count === 0);
}
