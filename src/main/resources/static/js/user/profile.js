async function loadOperativeData() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token'); 
    if (!savedUserStr || !token) return;
    
    const currentUser = JSON.parse(savedUserStr);
    const nameInput = document.getElementById('input-name');
    if (!nameInput) return; 

    try {
        const response = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, { headers: { 'Authorization': `Bearer ${token}` } });
        if (response.ok) {
            const user = await response.json();
            nameInput.value = user.name || '';
            if (document.getElementById('input-email')) document.getElementById('input-email').value = user.email || '';
            if (document.getElementById('input-phone')) document.getElementById('input-phone').value = user.phone || '';
            if (document.getElementById('input-bio')) document.getElementById('input-bio').value = user.description || '';
            if (document.getElementById('input-username')) document.getElementById('input-username').value = currentUser.username || '';
            const roleEl = document.getElementById('profile-role');
            if (roleEl) roleEl.innerText = user.role || 'MEMBER';

            // Load social links + bio from localStorage
            const _lsKey = `profile_links_${currentUser.id}`;
            const _saved = JSON.parse(localStorage.getItem(_lsKey) || '{}');
            if (document.getElementById('input-github'))  document.getElementById('input-github').value  = _saved.github  || '';
            if (document.getElementById('input-linkedin')) document.getElementById('input-linkedin').value = _saved.linkedin || '';
            if (document.getElementById('input-website')) document.getElementById('input-website').value  = _saved.website  || '';
            if (document.getElementById('input-bio') && _saved.bio) document.getElementById('input-bio').value = _saved.bio;

            // Load tags from experiences
            const tags = (user.experiences || []).map(e => e.name).filter(Boolean);
            _renderTags(tags);
        } else if (response.status === 403 || response.status === 401) { logout(); }
    } catch (error) { console.error("[SYSTEM] Error loading user data:", error); }

    loadMyMentorRequests();
}

// ── Tag system ─────────────────────────────────────────────────────────────

const _tagColors = ['tag-primary', 'tag-secondary', 'tag-tertiary', 'tag-gold'];

function _renderTags(tags) {
    const list = document.getElementById('tag-list');
    if (!list) return;
    list.innerHTML = tags.map((tag, i) => `
        <span class="inline-flex items-center gap-1.5 px-3 py-1 ${_tagColors[i % _tagColors.length]} text-[11px] font-mono">
            ${tag}
            <button onclick="removeTag('${tag.replace(/'/g, "\\'")}')" class="opacity-50 hover:opacity-100 transition-opacity leading-none">&times;</button>
        </span>`).join('');
}

function _getTags() {
    const list = document.getElementById('tag-list');
    if (!list) return [];
    return [...list.querySelectorAll('span')].map(s => s.childNodes[0].textContent.trim()).filter(Boolean);
}

function addTag() {
    const input = document.getElementById('tag-input');
    if (!input) return;
    const val = input.value.trim();
    if (!val) return;
    const current = _getTags();
    if (current.includes(val)) { showToast('Tag already exists', 'error'); return; }
    if (current.length >= 10) { showToast('Max 10 tags allowed', 'error'); return; }
    _renderTags([...current, val]);
    input.value = '';
    input.focus();
}

function removeTag(tag) {
    _renderTags(_getTags().filter(t => t !== tag));
}

function handleTagKeydown(event) {
    if (event.key === 'Enter') { event.preventDefault(); addTag(); }
}

async function handleAvatarUpload(event) {
    const file = event.target.files[0];
    if (!file) return;

    // Validate type & size (max 2MB)
    if (!file.type.startsWith('image/')) return showToast('Invalid file type. Images only.', 'error');
    if (file.size > 2 * 1024 * 1024)    return showToast('File too large. Max 2MB.', 'error');

    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return showToast('Session expired. Please log in again.', 'error');

    const currentUser = JSON.parse(savedUserStr);

    // Preview immediately (local blob URL)
    const previewUrl = URL.createObjectURL(file);
    const avatarImg = document.getElementById('profile-avatar');
    if (avatarImg) avatarImg.src = previewUrl;

    // Show uploading overlay
    const overlay = document.getElementById('avatar-upload-overlay');
    if (overlay) overlay.classList.remove('hidden');

    try {
        const formData = new FormData();
        formData.append('avatar', file);

        const response = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}/avatar`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` },
            body: formData
        });

        if (response.ok) {
            const data = await response.json();
            const newAvatarUrl = data.avatarUrl || previewUrl;

            // Persist new avatar URL in storage
            currentUser.avatar = newAvatarUrl;
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(currentUser));

            if (avatarImg) avatarImg.src = newAvatarUrl;
            showToast('Avatar updated successfully!', 'success');
        } else {
            // Backend not ready yet — keep local preview, save as base64 fallback
            const reader = new FileReader();
            reader.onload = e => {
                const base64 = e.target.result;
                currentUser.avatar = base64;
                const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
                storage.setItem('cyber_user', JSON.stringify(currentUser));
                if (avatarImg) avatarImg.src = base64;
            };
            reader.readAsDataURL(file);
            showToast('Avatar saved locally (server sync pending).', 'success');
        }
    } catch {
        // Offline fallback — base64 in storage
        const reader = new FileReader();
        reader.onload = e => {
            const base64 = e.target.result;
            currentUser.avatar = base64;
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(currentUser));
            if (avatarImg) avatarImg.src = base64;
        };
        reader.readAsDataURL(file);
        showToast('Avatar saved locally.', 'success');
    } finally {
        if (overlay) overlay.classList.add('hidden');
        // Reset input so same file can be re-selected
        event.target.value = '';
    }
}

async function saveAccountProfile() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return showToast('Error: Session expired. Please log in again.', 'error');

    const currentUser = JSON.parse(savedUserStr);
    const tags = _getTags();
    const usernameVal = document.getElementById('input-username')?.value.trim();
    const payload = {
        name: document.getElementById('input-name').value,
        email: document.getElementById('input-email').value,
        phone: document.getElementById('input-phone').value,
        description: document.getElementById('input-bio').value,
        experiences: tags.map(t => ({ name: t })),
        ...(usernameVal ? { username: usernameVal } : {})
    };

    try {
        const response = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify(payload)
        });
        if (response.ok) {
            // Persist social links + bio to localStorage (backend has no column for these)
            const _lsKey = `profile_links_${currentUser.id}`;
            localStorage.setItem(_lsKey, JSON.stringify({
                bio:      document.getElementById('input-bio')?.value     || '',
                github:   document.getElementById('input-github')?.value   || '',
                linkedin: document.getElementById('input-linkedin')?.value || '',
                website:  document.getElementById('input-website')?.value  || ''
            }));

            showToast('Profile saved successfully.', 'success');
            currentUser.name = payload.name;
            if (usernameVal) currentUser.username = usernameVal;
            const storage = localStorage.getItem('cyber_user') ? localStorage : sessionStorage;
            storage.setItem('cyber_user', JSON.stringify(currentUser));
            applyLoginState(currentUser);
            const _bonusKey = `profile_bonus_claimed_${currentUser.id}`;
            if (!localStorage.getItem(_bonusKey)) {
                localStorage.setItem(_bonusKey, '1');
                await _addCoinsToSelf(100, 'completing your profile');
            }
        } else {
            const errData = await response.json().catch(() => ({}));
            showToast(errData.message || 'Save failed. Try again.', 'error');
        }
    } catch (error) { showToast('Server error. Check your connection.', 'error'); }
}

async function openProfileModal(id) {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    const modal = document.getElementById('profile-modal');
    const modalContent = document.getElementById('profile-modal-content');
    const modalBody = document.getElementById('modal-body');
    
    // 1. GUEST scenario: no token, require login
    if (!token) return showToast("Please log in to view profiles!", "error");

    modal.classList.remove('hidden');
    setTimeout(() => modalContent.classList.remove('translate-x-full'), 10);
    modalBody.innerHTML = '<p class="text-primary font-mono animate-pulse text-center mt-20">Establishing secure connection... Fetching operative data...</p>';

    try {
        const response = await fetch(`${API_BASE_URL}/team/members/${id}`, { 
            headers: { 'Authorization': `Bearer ${token}` } 
        });
        
        if (!response.ok) throw new Error("Data access denied.");
        const user = await response.json(); 
        
        // --- Button visibility logic based on role ---
        const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
        if (!savedUserStr) { logout(); return; }
        const currentUser = JSON.parse(savedUserStr);
        const viewerRole = currentUser.role;

        let actionButtonsHTML = '';

        // Scenario 1: Viewing own profile
        if (currentUser.id === user.id) {
            actionButtonsHTML = `
                <button onclick="showPage('my-profile'); closeProfileModal();" class="w-full bg-secondary text-black font-bold font-mono tracking-widest py-3.5 hover:bg-white transition-all text-[11px]">
                    EDIT MY PROFILE
                </button>`;
        }
        // Scenario 2: Viewing another member's profile
        else {
            const safeName = user.name.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
            const viewerIsMentor = await fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            }).then(r => r.ok ? r.json() : {}).then(d => !!d.isMentor).catch(() => false);

            const pendingReq = (user.isMentor && !viewerIsMentor) ? await getMyPendingRequest(user.id) : null;
            if (user.isMentor && !viewerIsMentor && pendingReq) {
                actionButtonsHTML = `
                    <div class="w-full bg-yellow-500/10 border border-yellow-500/30 p-3 mb-3 text-center font-mono text-[10px] text-yellow-400 uppercase tracking-widest">
                        ● Request pending since ${new Date(pendingReq.createdAt).toLocaleDateString('en-GB',{day:'2-digit',month:'short',year:'numeric'})}
                    </div>
                    <button onclick="cancelMentorRequest(${user.id})" class="w-full bg-red-600/20 border border-red-500/50 text-red-400 font-bold font-mono tracking-widest py-3.5 hover:bg-red-600 hover:text-white transition-all text-[11px] mb-2">
                        CANCEL REQUEST
                    </button>`;
            } else if (user.isMentor && !viewerIsMentor) {
                actionButtonsHTML = `
                    <div id="mentor-request-form-${user.id}">
                        <button onclick="handleMentorRequest(${user.id}, '${safeName}')" class="w-full bg-primary text-black font-bold font-mono tracking-widest py-3.5 hover:bg-white transition-all text-[11px] mb-2">
                            MENTOR REQUEST (500 COINS)
                        </button>
                    </div>`;
            }
            actionButtonsHTML += `
                <div id="message-form-${user.id}" class="mt-2">
                    <button onclick="toggleMessageForm(${user.id})" class="w-full bg-[#111] border border-white/10 text-white font-bold font-mono tracking-widest py-3.5 hover:border-primary transition-all text-[11px]">
                        MESSAGE
                    </button>
                    <div id="message-box-${user.id}" class="hidden mt-2">
                        <textarea id="message-input-${user.id}" placeholder="Type your message..." class="w-full bg-[#0a0a0a] border border-white/10 text-white font-mono text-xs p-3 mb-2 resize-none h-20 focus:outline-none focus:border-primary/50 placeholder-gray-600"></textarea>
                        <button onclick="sendMessage(${user.id}, '${safeName}')" class="w-full bg-secondary text-black font-bold font-mono tracking-widest py-2.5 hover:brightness-110 transition-all text-[11px]">SEND</button>
                    </div>
                </div>`;

            // ADMIN privilege: show delete and award coins buttons
            if (viewerRole === 'ADMIN' || viewerRole === 'SUPER ADMIN') {
                actionButtonsHTML += `
                    <button onclick="openAwardCoinsModal(${user.id}, '${safeName}')" class="w-full mt-4 bg-primary/10 border border-primary/30 text-primary font-bold font-mono tracking-widest py-3.5 hover:bg-primary hover:text-black transition-all text-[11px]">
                        [ADMIN] AWARD COINS
                    </button>
                    <button onclick="adminDeleteUser(${user.id})" class="w-full mt-2 bg-red-600/20 border border-red-500/50 text-red-500 font-bold font-mono tracking-widest py-3.5 hover:bg-red-600 hover:text-white transition-all text-[11px]">
                        [ADMIN] TERMINATE OPERATIVE
                    </button>`;
            }
        }

        // --- Experience timeline ---
        const defaultAvt = "https://ui-avatars.com/api/?background=222&color=fff&name=";
        const avatarUrl = user.avatar || (defaultAvt + user.name);

        let experiencesHTML = '<p class="text-gray-500 font-mono text-sm">No classified records found.</p>';
        if (user.experiences && user.experiences.length > 0) {
            experiencesHTML = user.experiences.map((exp, index) => {
                const isLast = index === user.experiences.length - 1;
                const isActive = !exp.endDate || exp.endDate.toUpperCase() === 'PRESENT';
                
                let coursesHTML = '';
                if (exp.courseInfo) {
                    let courses = exp.courseInfo.includes(';') ? exp.courseInfo.split(';') : exp.courseInfo.split(',');
                    let tags = courses.map(c => {
                        let text = c.includes('@#') ? c.split('@#')[0].trim() : c.trim();
                        return isActive ? `<span class="bg-[#222] text-white text-[10px] px-2 py-1 border border-white/10">${text}</span>` : `<span class="text-gray-500 text-[11px] mr-3">${text}</span>`;
                    }).join('');
                    coursesHTML = `<div class="mt-3 flex flex-wrap gap-2">${tags}</div>`;
                }

                return `
                    <div class="relative pl-8 mb-10">
                        ${!isLast ? `<div class="absolute left-[3px] top-4 bottom-[-40px] w-[1px] ${isActive ? 'bg-primary/30' : 'bg-white/10'}"></div>` : ''}
                        <div class="absolute left-0 top-1.5 w-2 h-2 ${isActive ? 'bg-primary' : 'bg-gray-500'}"></div>
                        <h3 class="text-lg font-bold text-white leading-tight">${exp.organizationName}</h3>
                        <p class="${isActive ? 'text-primary' : 'text-gray-400'} font-mono text-[10px] tracking-widest uppercase mt-1">
                            ${exp.positionTitle} <span class="text-gray-600 mx-1">|</span> ${exp.startDate} - ${exp.endDate || 'PRESENT'}
                        </p>
                        ${coursesHTML}
                    </div>`;
            }).join('');
        }

        // --- FETCH EDUCATION ---
        let educationHTML = '';
        try {
            const eduRes = await fetch(`${API_BASE_URL}/team/members/${id}/education`, { headers: { 'Authorization': `Bearer ${token}` } });
            if (eduRes.ok) {
                const eduList = await eduRes.json();
                if (eduList.length > 0) {
                    educationHTML = `
                        <div class="mt-10 pt-6 border-t border-white/5">
                            <h2 class="text-3xl font-bold text-white mb-8 pb-4 border-b border-white/10">Education</h2>
                            <div class="space-y-6">
                                ${eduList.map((e, i) => `
                                    <div class="relative pl-8">
                                        ${i < eduList.length - 1 ? '<div class="absolute left-[3px] top-4 bottom-[-24px] w-[1px] bg-white/10"></div>' : ''}
                                        <div class="absolute left-0 top-1.5 w-2 h-2 bg-gray-500"></div>
                                        <h3 class="text-base font-bold text-white">${e.institution}</h3>
                                        <p class="text-gray-400 font-mono text-[10px] uppercase tracking-widest mt-1">${e.title}${e.specialization ? ' · ' + e.specialization : ''}</p>
                                        <p class="text-gray-600 font-mono text-[10px] mt-0.5">${e.startYear} — ${e.endYear || 'Present'}${e.gpa && e.gpa > 0 ? ' · GPA: ' + e.gpa : ''}</p>
                                    </div>`).join('')}
                            </div>
                        </div>`;
                }
            }
        } catch {}

        // --- Mentor profile hero (only for mentor accounts) ---
        let mentorHeroHTML = '';
        if (user.isMentor) {
            // Skill tags from all experiences
            const allSkillTags = (user.experiences || [])
                .flatMap(e => (e.tags || '').split(',').map(t => t.trim()).filter(Boolean));
            const uniqueSkills = [...new Set(allSkillTags)].slice(0, 8);
            const skillPillsHTML = uniqueSkills.map(t =>
                `<span class="font-mono text-[9px] uppercase tracking-wider px-2 py-1 border border-tertiary/40 text-tertiary/90 bg-tertiary/5">${t}</span>`
            ).join('');

            // Social links from team.social field (format: "platform:url@#platform:url")
            const socialLinksHTML = (() => {
                if (!user.mentorSocial) return '';
                const icons = { github: '⌥', linkedin: 'in', facebook: 'f', youtube: '▶', twitter: 'X', website: '🌐' };
                const links = user.mentorSocial.split('@#').map(s => {
                    const colonIdx = s.indexOf(':');
                    if (colonIdx === -1) return '';
                    const platform = s.slice(0, colonIdx).toLowerCase().trim();
                    const url = s.slice(colonIdx + 1).trim();
                    if (!url.startsWith('http')) return '';
                    const label = icons[platform] || platform.toUpperCase().slice(0, 2);
                    return `<a href="${url}" target="_blank" rel="noopener" class="font-mono text-[9px] uppercase tracking-wider px-2.5 py-1.5 border border-white/10 text-gray-400 hover:border-primary/50 hover:text-primary transition-all">${label}</a>`;
                }).join('');
                return links ? `<div class="flex flex-wrap gap-2 mt-4">${links}</div>` : '';
            })();

            const rateText = user.mentorRate
                ? `<span class="font-mono text-[10px] text-primary border border-primary/30 px-2 py-0.5">${user.mentorRate.toLocaleString()} ${user.mentorCurrency || 'COIN'} / hr</span>`
                : '';

            mentorHeroHTML = `
                <div class="mb-8 p-6 bg-[#111] border border-tertiary/20 relative overflow-hidden">
                    <div class="absolute top-0 left-0 right-0 h-[1px] bg-gradient-to-r from-transparent via-tertiary/50 to-transparent"></div>
                    <div class="flex items-center gap-3 mb-3">
                        <span class="font-mono text-[9px] font-bold tracking-[0.25em] uppercase px-2 py-0.5 border text-tertiary border-tertiary/50 bg-tertiary/5">MENTOR</span>
                        ${user.mentorTitle ? `<span class="font-mono text-[10px] text-gray-500">${user.mentorTitle}</span>` : ''}
                        ${rateText}
                    </div>
                    ${user.mentorPosition ? `<p class="font-headline font-bold text-white text-lg mb-3">${user.mentorPosition}</p>` : ''}
                    ${user.mentorBio ? `<p class="text-gray-400 text-sm leading-relaxed mb-4">${user.mentorBio}</p>` : ''}
                    ${skillPillsHTML ? `<div class="flex flex-wrap gap-1.5 mb-2">${skillPillsHTML}</div>` : ''}
                    ${socialLinksHTML}
                </div>`;
        }

        // --- RENDER  ---
        modalBody.innerHTML = `
            <div class="grid grid-cols-1 lg:grid-cols-[1fr_2fr] gap-12 mt-4">
                <div class="space-y-6">
                    <div class="p-1 border border-white/10 bg-[#111] shadow-2xl">
                        <img src="${avatarUrl}" class="w-full aspect-square object-cover grayscale" />
                    </div>

                    <div id="modal-actions-container">
                        ${actionButtonsHTML}
                    </div>

                    <div class="bg-[#111] border-y border-r border-white/5 p-6 mt-6 relative overflow-hidden">
                        <div class="absolute left-0 top-0 bottom-0 w-[3px] bg-primary"></div>
                        <h4 class="text-primary font-mono text-[10px] tracking-[0.2em] uppercase mb-6 font-bold">TACTICAL DATA</h4>
                        <div class="space-y-5">
                            <div><p class="text-[9px] font-bold text-gray-500 uppercase mb-1">PHONE</p><p class="text-white font-mono text-xs tracking-widest">${user.phone || 'CLASSIFIED'}</p></div>
                            <div><p class="text-[9px] font-bold text-gray-500 uppercase mb-1">ADDRESS</p><p class="text-white font-mono text-xs tracking-wide">${user.address || 'UNKNOWN'}</p></div>
                            <div><p class="text-[9px] font-bold text-gray-500 uppercase mb-1">EMAIL</p><p class="text-white font-mono text-xs break-all">${user.email || 'ENCRYPTED'}</p></div>
                        </div>
                    </div>
                </div>
                <div>
                    ${mentorHeroHTML}
                    <h2 class="text-3xl font-bold text-white mb-8 pb-4 border-b border-white/10">Experience</h2>
                    <div class="space-y-2">${experiencesHTML}</div>
                    ${educationHTML}
                    ${!user.isMentor ? `
                    <div class="mt-10 pt-6 border-t border-white/5">
                         <h4 class="text-gray-500 font-mono text-[10px] uppercase tracking-widest mb-4">Briefing Notes</h4>
                         <p class="text-gray-400 text-sm leading-relaxed font-mono">${user.description || 'No additional logs found.'}</p>
                    </div>` : ''}
                </div>
            </div>`;

    } catch (error) { 
        modalBody.innerHTML = `<p class="text-red-500 font-mono text-center mt-20">CONNECTION TERMINATED. ${error.message}</p>`; 
    }
}

function closeProfileModal() {
    const modalContent = document.getElementById('profile-modal-content');
    if (modalContent) modalContent.classList.add('translate-x-full');
    setTimeout(() => document.getElementById('profile-modal').classList.add('hidden'), 300);
}
// ================================================================
//  PORTFOLIO / VERIFIED CV — Proof of Work Center
//  Sections: §1 Hero  §2 Stats  §3 Skills  §4 Timeline
// ================================================================

async function loadPortfolioData() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    if (!savedUserStr || !token) return;

    const currentUser = JSON.parse(savedUserStr);
    if (!document.getElementById('portfolio-name')) return; // guard: page not in DOM yet

    try {
        const [userRes, rankRes] = await Promise.all([
            fetch(`${API_BASE_URL}/team/members/${currentUser.id}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            }),
            fetch(`${API_BASE_URL}/ranking`).catch(() => null)
        ]);

        if (!userRes.ok) {
            if (userRes.status === 401 || userRes.status === 403) logout();
            return;
        }

        const user = await userRes.json();

        // Match current user in public ranking list (by name)
        let userRank = 0, userScore = 0;
        if (rankRes && rankRes.ok) {
            const rankList = await rankRes.json();
            const idx = Array.isArray(rankList)
                ? rankList.findIndex(r => r.name === user.name)
                : -1;
            if (idx >= 0) { userRank = idx + 1; userScore = rankList[idx].point || 0; }
        }

        _pfRenderHero(user);
        _pfRenderStats(user, userRank, userScore);
        _pfRenderSkills(user.experiences || []);
        _pfRenderTimeline(user.experiences || []);
        _pfRenderContributions(user);
        _pfRenderEducation(currentUser.id, token);

    } catch (err) {
        console.error("[PORTFOLIO]", err);
        ['pf-skills-certified','pf-skills-declared'].forEach(id => {
            const el = document.getElementById(id);
            if (el && el.querySelector('.italic')?.textContent === 'Loading...')
                el.innerHTML = '<span class="font-mono text-[10px] text-on-surface-variant italic">—</span>';
        });
    }
}

/* §1 — populate hero: avatar, name, role tag, UID, clearance, bio, social links */
function _pfRenderHero(user) {
    const get = id => document.getElementById(id);
    const set = (id, v) => { const el = get(id); if (el) el.textContent = v; };

    const defaultAvt = `https://ui-avatars.com/api/?background=222&color=fff&name=${encodeURIComponent(user.name || 'Operative')}`;
    const img = get('portfolio-avatar');
    if (img) img.src = user.avatar || defaultAvt;

    set('portfolio-name', user.name || 'UNKNOWN OPERATIVE');
    set('portfolio-uid',  String(user.id || 0).padStart(6, '0'));

    // Bio from localStorage (backend has no description column)
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const currentUser  = savedUserStr ? JSON.parse(savedUserStr) : {};
    const _lsKey = `profile_links_${currentUser.id}`;
    const _saved = JSON.parse(localStorage.getItem(_lsKey) || '{}');
    const bioEl = get('portfolio-bio');
    if (bioEl) bioEl.textContent = _saved.bio || 'No briefing notes on file.';

    // Role tag colour
    const roleTag = get('portfolio-role-tag');
    if (roleTag) {
        const isAdmin = (user.role || '').toUpperCase().includes('ADMIN');
        roleTag.textContent = user.role || 'MEMBER';
        roleTag.className   = (isAdmin ? 'tag-tertiary' : 'tag-primary') +
                              ' px-2.5 py-0.5 text-[10px] font-mono uppercase tracking-widest shrink-0';
    }

    // MENTOR / MENTEE badge
    const mentorBadge = get('portfolio-mentor-badge');
    if (mentorBadge) {
        if (user.isMentor) {
            mentorBadge.textContent = 'MENTOR';
            mentorBadge.className = 'font-mono text-[9px] font-bold tracking-widest px-2 py-0.5 border border-tertiary/50 text-tertiary';
        } else {
            mentorBadge.textContent = 'MENTEE';
            mentorBadge.className = 'font-mono text-[9px] font-bold tracking-widest px-2 py-0.5 border border-secondary/50 text-secondary';
        }
    }

    set('portfolio-clearance-line', `ROLE: ${user.role || 'MEMBER'}`);

    // Social links
    const socialEl = get('portfolio-social-links');
    if (socialEl) {
        const links = [];
        const _icon = (icon, label, url) => url ? `
            <a href="${url}" target="_blank" rel="noopener"
               class="flex items-center gap-1 font-mono text-[10px] text-on-surface-variant hover:text-primary transition-colors border border-outline-variant/20 px-2 py-1 hover:border-primary/40">
               <span class="material-symbols-outlined text-[12px]">${icon}</span>${label}
            </a>` : '';
        links.push(_icon('code',        'GitHub',   _saved.github));
        links.push(_icon('work',        'LinkedIn', _saved.linkedin));
        links.push(_icon('language',    'Website',  _saved.website));
        socialEl.innerHTML = links.join('') || '';
        socialEl.classList.toggle('hidden', !links.some(l => l));
    }
}

/* §2 — populate stat cards */
function _pfRenderStats(user, rank, score) {
    const set = (id, v) => { const el = document.getElementById(id); if (el) el.textContent = v; };

    set('pf-xp',       score > 0 ? score.toLocaleString() : '0');
    set('pf-stat-rank', rank > 0 ? `#${rank}` : '#--');
    set('pf-projects',  (user.experiences || []).length);
    // Workshops = experiences that recorded a courseInfo (training/course data present)
    set('pf-workshops', (user.experiences || []).filter(e => e.courseInfo && e.courseInfo.trim()).length);
}

/* §3 — build verified skill tag pills */
function _pfRenderSkills(experiences) {
    const certEl = document.getElementById('pf-skills-certified');
    const declEl = document.getElementById('pf-skills-declared');
    if (!certEl || !declEl) return;

    const certified = new Set();
    const declared  = new Set();

    experiences.forEach(exp => {
        if (!exp.courseInfo) return;
        const parts = exp.courseInfo.includes(';')
            ? exp.courseInfo.split(';')
            : exp.courseInfo.split(',');
        parts.forEach(p => {
            p = p.trim();
            if (!p) return;
            p.includes('@#')
                ? certified.add(p.split('@#')[0].trim())
                : declared.add(p);
        });
    });

    // Verified icon used inside every pill
    const checkIcon = `<span class="material-symbols-outlined" ` +
        `style="font-size:10px;font-variation-settings:'FILL' 1;line-height:1">check_circle</span>`;

    certEl.innerHTML = certified.size
        ? [...certified].map(n =>
            `<span class="pf-skill-tag tag-primary">${checkIcon}${n}</span>`
          ).join('')
        : '<span class="font-mono text-[10px] text-on-surface-variant italic">No system-certified skills on record.</span>';

    const altClass = ['tag-secondary', 'tag-tertiary'];
    declEl.innerHTML = declared.size
        ? [...declared].map((n, i) =>
            `<span class="pf-skill-tag ${altClass[i % 2]}">${checkIcon}${n}</span>`
          ).join('')
        : '<span class="font-mono text-[10px] text-on-surface-variant italic">No declared skills on record.</span>';
}

/* §4 — build proof-of-work vertical timeline */
function _pfRenderTimeline(experiences) {
    const container = document.getElementById('pf-timeline-container');
    if (!container) return;

    if (!experiences.length) {
        container.innerHTML = `<div class="pf-timeline-line"></div>
            <p class="font-mono text-[10px] text-on-surface-variant italic pl-2">No proof-of-work records on file.</p>`;
        return;
    }

    // Active deployments first, then newest by startDate
    const sorted = [...experiences].sort((a, b) => {
        const aLive = !a.endDate || a.endDate.toUpperCase() === 'PRESENT';
        const bLive = !b.endDate || b.endDate.toUpperCase() === 'PRESENT';
        if (aLive && !bLive) return -1;
        if (!aLive && bLive) return 1;
        return (b.startDate || '').localeCompare(a.startDate || '');
    });

    const nodes = sorted.map(exp => {
        const isLive = !exp.endDate || exp.endDate.toUpperCase() === 'PRESENT';

        const statusTag = isLive
            ? `<span class="tag-primary px-2 py-0.5 text-[8px] font-mono">ACTIVE</span>`
            : `<span class="tag-secondary px-2 py-0.5 text-[8px] font-mono">COMPLETED</span>`;

        // Skill chips (max 5) — certified chips show a verified icon
        let skillsHTML = '';
        if (exp.courseInfo) {
            const parts = (exp.courseInfo.includes(';')
                ? exp.courseInfo.split(';')
                : exp.courseInfo.split(','))
                .filter(p => p.trim()).slice(0, 5);

            const chips = parts.map(p => {
                const isCert = p.includes('@#');
                const name   = (isCert ? p.split('@#')[0] : p).trim();
                const icon   = isCert
                    ? `<span class="material-symbols-outlined" style="font-size:9px;font-variation-settings:'FILL' 1;line-height:1">verified</span>`
                    : '';
                return name
                    ? `<span class="${isCert ? 'tag-tertiary' : 'tag-secondary'} px-2 py-0.5 text-[8px] font-mono inline-flex items-center gap-1">${icon}${name}</span>`
                    : '';
            }).join('');
            if (chips) skillsHTML = `<div class="flex flex-wrap gap-1.5 mt-3">${chips}</div>`;
        }

        return `
        <div class="pf-timeline-node">
          <div class="pf-timeline-dot ${isLive ? '' : 'inactive'}"></div>
          <div class="glass-panel pf-timeline-card">
            <div class="flex items-start justify-between gap-3 flex-wrap">
              <div class="space-y-1 min-w-0">
                <div class="flex items-center gap-2 flex-wrap">
                  ${statusTag}
                  <span class="font-mono text-[9px] text-on-surface-variant tracking-widest">
                    ${exp.startDate || '???'} — ${exp.endDate || 'PRESENT'}
                  </span>
                </div>
                <h3 class="font-headline text-base font-bold text-white leading-tight">
                  ${exp.organizationName || 'Unnamed Organisation'}
                </h3>
                <p class="font-mono text-[10px] ${isLive ? 'text-primary' : 'text-on-surface-variant'} uppercase tracking-widest">
                  ${exp.positionTitle || 'OPERATIVE'}
                </p>
              </div>
              <button onclick="showToast('Project details coming soon!', 'success')"
                class="shrink-0 text-[9px] font-mono text-on-surface-variant border border-outline-variant/30 px-3 py-1.5 hover:border-primary hover:text-primary transition-all uppercase tracking-widest flex items-center gap-1.5">
                <span class="material-symbols-outlined" style="font-size:12px;line-height:1">open_in_new</span>
                VIEW
              </button>
            </div>
            ${skillsHTML}
          </div>
        </div>`;
    }).join('');

    container.innerHTML = `<div class="pf-timeline-line"></div>${nodes}`;
}

/* §6 — Education records */
async function _pfRenderEducation(userId, token) {
    const section   = document.getElementById('pf-education-section');
    const container = document.getElementById('pf-education-container');
    if (!section || !container) return;
    try {
        const res = await fetch(`${API_BASE_URL}/team/members/${userId}/education`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return;
        const list = await res.json();
        if (!list.length) return;

        container.innerHTML = list.map((e, i) => `
            <div class="glass-panel p-5 relative overflow-hidden">
                <div class="flex items-start justify-between gap-4 flex-wrap">
                    <div class="space-y-1 min-w-0">
                        <div class="flex items-center gap-2 flex-wrap">
                            ${e.institutionLogo ? `<img src="${e.institutionLogo}" class="w-5 h-5 object-contain grayscale" onerror="this.remove()"/>` : ''}
                            <h3 class="font-headline text-sm font-bold text-white">${e.institution || 'Unknown Institution'}</h3>
                        </div>
                        <p class="font-mono text-[10px] text-primary uppercase tracking-widest">${e.title || ''}${e.specialization ? ' · ' + e.specialization : ''}</p>
                        <p class="font-mono text-[9px] text-on-surface-variant">${e.startYear || '?'} — ${e.endYear || 'Present'}${e.studyMode ? ' · ' + e.studyMode : ''}${e.gpa && e.gpa > 0 ? ' · GPA ' + e.gpa : ''}</p>
                        ${e.thesisTitle ? `<p class="font-mono text-[9px] text-on-surface-variant mt-1 italic">"${e.thesisTitle}"${e.thesisUrl ? ` <a href="${e.thesisUrl}" target="_blank" class="text-primary hover:underline">[link]</a>` : ''}</p>` : ''}
                    </div>
                    ${e.institutionWebsite ? `<a href="${e.institutionWebsite}" target="_blank" rel="noopener" class="shrink-0 text-[9px] font-mono text-on-surface-variant border border-outline-variant/30 px-3 py-1.5 hover:border-primary hover:text-primary transition-all uppercase tracking-widest">Visit</a>` : ''}
                </div>
            </div>`).join('');

        section.classList.remove('hidden');
    } catch { /* education not available, keep section hidden */ }
}

/* §5 — Project contribution analytics (UC005) */
async function _pfRenderContributions(user) {
    const container = document.getElementById('pf-contributions-container');
    if (!container) return;
    try {
        const response = await fetch(`${API_BASE_URL}/projects`);
        if (!response.ok) throw new Error();
        const projects = await response.json();
        const mine = projects.filter(p =>
            (p.members || []).some(m =>
                m.memberName === user.name || String(m.memberId) === String(user.id)
            )
        );
        if (!mine.length) {
            container.innerHTML = `<span class="font-mono text-[10px] text-on-surface-variant italic">No project contributions on record.</span>`;
            return;
        }
        container.innerHTML = mine.map(p => {
            const myMember = (p.members || []).find(m => m.memberName === user.name);
            const total = p.totalTasks || 0;
            const done = p.completedTasks || 0;
            const pct = total ? Math.round((done / total) * 100) : 0;
            return `
                <div class="bg-surface-container-low border border-outline-variant/20 p-4 hover:border-primary/30 transition-all">
                    <div class="flex items-center justify-between mb-3">
                        <div>
                            <h4 class="text-white font-bold text-sm font-headline">${p.name}</h4>
                            <p class="font-mono text-[10px] text-on-surface-variant uppercase mt-0.5">${myMember ? myMember.role : 'Contributor'}</p>
                        </div>
                        <span class="font-mono text-xs text-primary font-bold">${pct}%</span>
                    </div>
                    <div class="skill-bar">
                        <div class="skill-bar-fill verified" style="width:${pct}%" data-w="${pct}"></div>
                    </div>
                    <p class="font-mono text-[9px] text-on-surface-variant mt-2">${done} / ${total} tasks completed</p>
                </div>`;
        }).join('');
    } catch {
        container.innerHTML = `<span class="font-mono text-[10px] text-on-surface-variant italic">Contribution data unavailable.</span>`;
    }
}

function generateVerifiedCV() {
    const portfolio = document.getElementById('page-portfolio');
    if (!portfolio) { showToast('Navigate to your portfolio first', 'error'); return; }

    const styles = Array.from(document.querySelectorAll('link[rel="stylesheet"]'))
        .map(l => `<link rel="stylesheet" href="${l.href}"/>`)
        .join('');

    const tailwindConfig = document.querySelector('script[src*="tailwindcss"]')?.outerHTML || '';
    const configScript = document.querySelector('script:not([src])')?.outerHTML || '';
    const gFonts = Array.from(document.querySelectorAll('link[href*="fonts.googleapis"]'))
        .map(l => l.outerHTML).join('');

    const html = `<!DOCTYPE html>
<html class="dark">
<head>
<meta charset="utf-8"/>
<title>CyberTitans — Verified CV</title>
${tailwindConfig}
${configScript}
${gFonts}
${styles}
</head>
<body class="bg-[#0e0e0e] text-white font-body p-8">
${portfolio.innerHTML}
<script>
window.onload = function() {
    document.querySelectorAll('.skill-bar-fill[data-w]').forEach(function(el) {
        el.style.width = el.dataset.w + '%';
    });
    setTimeout(function() { window.print(); }, 600);
};
<\/script>
</body>
</html>`;

    const blob = new Blob([html], { type: 'text/html;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    window.open(url, '_blank');
    showToast('CV export opened — print or save as PDF', 'success');
}

function deleteSelfAccount() {
    const savedUserStr = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    if (!savedUserStr) return showToast('Session expired.', 'error');

    const currentUser = JSON.parse(savedUserStr);
    const input = document.getElementById('delete-confirm-input');
    const typed = input ? input.value.trim() : '';

    if (!typed || typed !== currentUser.username) {
        showToast('Username does not match. Request cancelled.', 'error');
        return;
    }

    closeModal('delete-account-modal');
    if (input) input.value = '';
    showToast('Request submitted. An admin will review your deletion request.', 'success');
}

async function adminDeleteUser(userId) {
    const confirmation = confirm("⚠️ WARNING: You are sure you want to expel this member from the system?");
    if (!confirmation) return;

    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');

    try {
        const response = await fetch(`${API_BASE_URL}/team/members/${userId}`, {
            method: 'DELETE',
            headers: { 
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            showToast("User deleted successfully!", "success");
            closeProfileModal(); 
            buildTeam(); 
        } else {
            const errorData = await response.json();
            showToast(`ERROR: ${errorData.message || 'Access denied.'}`, "error");
        }
    } catch (error) {
        showToast("SERVER ERROR: Cannot connect to the server.", "error");
    }
}

// ── MY MENTOR REQUESTS (mentee notifications) ──────────────────────────────
async function loadMyMentorRequests() {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    const section = document.getElementById('my-requests-section');
    const list = document.getElementById('my-requests-list');
    if (!section || !list || !token) return;

    try {
        const res = await fetch(`${API_BASE_URL}/mentor/my-requests`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!res.ok) return;
        const requests = await res.json();
        if (!requests.length) return;

        section.classList.remove('hidden');

        const seenKey = 'seen_request_ids';
        const seen = new Set(JSON.parse(localStorage.getItem(seenKey) || '[]'));
        const hasNew = requests.some(r => (r.status === 'ACCEPTED' || r.status === 'REJECTED') && !seen.has(r.id));
        const badge = document.getElementById('requests-new-badge');
        if (badge) badge.classList.toggle('hidden', !hasNew);

        const statusStyle = {
            PENDING:   'text-yellow-400 border-yellow-400/30 bg-yellow-400/5',
            ACCEPTED:  'text-primary border-primary/30 bg-primary/5',
            REJECTED:  'text-red-400 border-red-500/30 bg-red-500/5',
            CANCELLED: 'text-gray-500 border-white/10 bg-white/5',
        };
        const statusIcon = { PENDING: '⏳', ACCEPTED: '✓', REJECTED: '✗', CANCELLED: '—' };

        list.innerHTML = requests.map(r => {
            const style = statusStyle[r.status] || statusStyle.PENDING;
            const icon  = statusIcon[r.status]  || '⏳';
            const isNew = (r.status === 'ACCEPTED' || r.status === 'REJECTED') && !seen.has(r.id);
            return `
            <div class="bg-[#0a0a0a] border ${isNew ? 'border-primary/30' : 'border-white/5'} p-5 flex items-center justify-between gap-4 flex-wrap transition-all">
                <div>
                    <div class="flex items-center gap-2 mb-1">
                        <span class="font-mono text-[9px] uppercase tracking-widest px-2 py-0.5 border ${style}">${icon} ${r.status}</span>
                        ${isNew ? '<span class="font-mono text-[9px] font-bold text-primary animate-pulse">● NEW</span>' : ''}
                    </div>
                    <p class="text-white font-bold font-headline">${r.mentorName || 'Mentor'}</p>
                    <p class="font-mono text-[10px] text-gray-500 mt-0.5">${new Date(r.createdAt).toLocaleDateString('en-GB',{day:'2-digit',month:'short',year:'numeric'})}</p>
                </div>
                <div class="flex items-center gap-2">
                    ${r.status === 'PENDING' ? `<button onclick="cancelMentorRequest(${r.id})" class="px-4 py-2 bg-red-600/10 border border-red-500/30 text-red-400 font-mono text-[9px] uppercase tracking-widest hover:bg-red-600 hover:text-white transition-all">CANCEL</button>` : ''}
                </div>
            </div>`;
        }).join('');

        // Mark ACCEPTED/REJECTED as seen
        requests.forEach(r => { if (r.status === 'ACCEPTED' || r.status === 'REJECTED') seen.add(r.id); });
        localStorage.setItem(seenKey, JSON.stringify([...seen]));

    } catch {}
}

async function cancelMentorRequest(reqId) {
    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    try {
        const res = await fetch(`${API_BASE_URL}/mentor/requests/${reqId}/cancel`, {
            method: 'POST', headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) { showToast('Request cancelled.', 'success'); loadMyMentorRequests(); }
        else showToast('Failed to cancel.', 'error');
    } catch { showToast('Error cancelling request.', 'error'); }
}

function toggleMessageForm(userId) {
    const box = document.getElementById(`message-box-${userId}`);
    if (box) box.classList.toggle('hidden');
}

function sendMessage(userId, userName) {
    const input = document.getElementById(`message-input-${userId}`);
    const msg = input ? input.value.trim() : '';
    if (!msg) return showToast('Please type a message first.', 'error');
    showToast(`Message sent to ${userName}!`, 'success');
    const box = document.getElementById(`message-box-${userId}`);
    if (box) box.classList.add('hidden');
    if (input) input.value = '';
}