const STATIC_PROJECTS = [
    {
        id: 1, name: 'CyberTitans Web Platform', status: 'ACTIVE',
        description: 'Full-stack club management system built with Spring Boot and Vanilla JS. Features member profiles, mentor matching, dynamic CV generation, and a Cyber Coin economy.',
        techStack: ['Spring Boot', 'Java', 'MySQL', 'Tailwind CSS', 'Vanilla JS'],
        members: [
            { memberName: 'Vũ Sơn Thái',     role: 'Lead Dev'  },
            { memberName: 'Nguyễn Minh Khoa', role: 'Backend'   },
            { memberName: 'Trần Thị Lan',     role: 'Frontend'  }
        ],
        totalTasks: 24, completedTasks: 18
    },
    {
        id: 2, name: 'CTF Automated Scorer', status: 'ACTIVE',
        description: 'Real-time Capture The Flag scoring engine with dynamic flag verification, team leaderboards via WebSocket, and Docker-based challenge sandboxing.',
        techStack: ['Python', 'FastAPI', 'Docker', 'Redis', 'WebSocket'],
        members: [
            { memberName: 'Lê Hoàng Nam',  role: 'Architect' },
            { memberName: 'Phạm Quốc Huy', role: 'DevOps'    }
        ],
        totalTasks: 16, completedTasks: 10
    },
    {
        id: 3, name: 'Network Intrusion Detector', status: 'IN_PROGRESS',
        description: 'ML-based IDS that classifies network traffic using a Random Forest model trained on the NSL-KDD dataset. Achieves 97.4% accuracy on test set.',
        techStack: ['Python', 'Scikit-learn', 'Pandas', 'Wireshark', 'Flask'],
        members: [
            { memberName: 'Đỗ Thanh Tùng', role: 'ML Engineer'  },
            { memberName: 'Bùi Thị Mai',   role: 'Data Analyst' },
            { memberName: 'Nguyễn Văn An', role: 'Backend'       }
        ],
        totalTasks: 20, completedTasks: 13
    },
    {
        id: 4, name: 'SecureVault Password Manager', status: 'COMPLETED',
        description: 'End-to-end encrypted password manager with AES-256 vault storage, TOTP-based 2FA, and a browser extension for auto-fill. Open-sourced on the club GitHub.',
        techStack: ['React', 'Node.js', 'AES-256', 'TOTP', 'MongoDB'],
        members: [
            { memberName: 'Hoàng Thị Thu', role: 'Full Stack' },
            { memberName: 'Trần Minh Đức', role: 'Security'   }
        ],
        totalTasks: 18, completedTasks: 18
    }
];

function _projectStatusTag(status) {
    switch ((status || '').toUpperCase()) {
        case 'ACTIVE':
        case 'IN_PROGRESS': return { cls: 'tag-primary',   label: status };
        case 'COMPLETED':   return { cls: 'tag-gold',      label: 'COMPLETED' };
        case 'ON_HOLD':
        case 'PAUSED':      return { cls: 'tag-tertiary',  label: status };
        default:            return { cls: 'tag-secondary', label: status || 'UNKNOWN' };
    }
}

function _buildProjectCard(p) {
    const st = _projectStatusTag(p.status);
    const progress = p.totalTasks ? Math.round((p.completedTasks / p.totalTasks) * 100) : 0;
    const techTags = (p.techStack || []).map(t =>
        `<span class="tag-secondary pf-skill-tag">${t}</span>`
    ).join('');
    const memberRows = (p.members || []).slice(0, 3).map(m => `
        <div class="flex items-center gap-2">
            <div class="w-5 h-5 bg-[#1a1a1a] border border-white/10 flex items-center justify-center font-mono text-[9px] text-primary">${m.memberName.charAt(0).toUpperCase()}</div>
            <span class="font-mono text-[10px] text-gray-400 flex-1 truncate">${m.memberName}</span>
            <span class="tag-tertiary pf-skill-tag">${m.role}</span>
        </div>`).join('');

    const savedUser = sessionStorage.getItem('cyber_user') || localStorage.getItem('cyber_user');
    const currentUser = savedUser ? JSON.parse(savedUser) : null;
    const isOwner = currentUser && String(currentUser.id) === String(p.userId);
    const ownerActions = isOwner ? `
        <div class="flex gap-2 mt-2">
            <button onclick="openEditProjectModal(${p.id})"
                class="flex-1 text-primary font-mono text-[10px] uppercase border border-primary/20 px-3 py-2 hover:bg-primary hover:text-black transition-all flex items-center justify-center gap-1">
                <span class="material-symbols-outlined text-[13px]">desktop_windows</span> Edit
            </button>
            <button onclick="deleteProject(${p.id}, '${(p.name||'').replace(/'/g,"\\'")}' )"
                class="flex-1 text-red-400 font-mono text-[10px] uppercase border border-red-500/30 px-3 py-2 hover:bg-red-600 hover:text-white transition-all flex items-center justify-center gap-1">
                <span class="material-symbols-outlined text-[13px]">delete</span> Delete
            </button>
        </div>` : '';

    return `
        <div class="hack-card p-6 card-lift flex flex-col">
            <div class="scanner"></div>
            <div class="flex items-start justify-between mb-4">
                <div>
                    <p class="font-mono text-[10px] uppercase tracking-[0.2em] text-gray-500 mb-1">/PROJECT</p>
                    <h3 class="font-headline text-xl font-bold text-white">${p.name}</h3>
                </div>
                <span class="${st.cls} pf-skill-tag shrink-0 ml-3">${st.label}</span>
            </div>
            <p class="font-mono text-xs text-gray-500 mb-4 leading-relaxed">${p.description || '—'}</p>
            <div class="flex flex-wrap gap-2 mb-4">${techTags}</div>
            ${memberRows ? `<div class="border-t border-white/5 pt-4 mb-4 space-y-2">${memberRows}</div>` : ''}
            <div class="mt-auto">
                <div class="mb-5">
                    <div class="flex justify-between font-mono text-[10px] mb-1 text-gray-500">
                        <span>TASKS</span><span>${p.completedTasks || 0} / ${p.totalTasks || 0}</span>
                    </div>
                    <div class="skill-bar">
                        <div class="skill-bar-fill verified" style="width:0%" data-w="${progress}"></div>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button onclick="openProjectModal(${p.id})" class="flex-1 text-primary font-mono text-[10px] uppercase border border-primary/20 px-4 py-2 hover:bg-primary hover:text-black transition-all">
                        View Project
                    </button>
                    ${p.githubUrl ? `<a href="${p.githubUrl}" target="_blank" rel="noopener noreferrer"
                        class="px-3 py-2 border border-white/10 text-on-surface-variant hover:border-primary/40 hover:text-primary transition-all flex items-center justify-center"
                        title="View on GitHub">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0 0 24 12c0-6.63-5.37-12-12-12z"/></svg>
                    </a>` : ''}
                </div>
                ${ownerActions}
            </div>
        </div>`;
}

function _animateProgressBars(container) {
    requestAnimationFrame(() => {
        container.querySelectorAll('.skill-bar-fill[data-w]').forEach(el => {
            el.style.width = el.dataset.w + '%';
        });
    });
}

async function buildProjects() {
    const container = document.getElementById('projects-container');
    if (!container) return;
    const btn = document.getElementById('create-project-btn');
    if (btn) {
        if (isLoggedIn) btn.classList.replace('hidden', 'flex');
        else btn.classList.replace('flex', 'hidden');
    }
    try {
        const response = await fetch(`${API_BASE_URL}/projects`);
        if (!response.ok) throw new Error('fetch failed');
        const projects = await response.json();
        if (!projects.length) {
            container.innerHTML = `<div class="col-span-full text-center font-mono text-gray-500 text-xs uppercase tracking-widest py-20">[ No projects found ]</div>`;
            return;
        }
        container.innerHTML = projects.map(p => _buildProjectCard(p)).join('');
        _animateProgressBars(container);
    } catch (err) {
        console.error('Projects error:', err);
        container.innerHTML = `<div class="col-span-full text-center font-mono text-gray-500 text-xs uppercase tracking-widest py-20">[ Failed to load projects ]</div>`;
    }
}

let _editingProjectId = null;

function openCreateProjectModal() {
    _editingProjectId = null;
    ['cp-name','cp-description','cp-tech','cp-total-tasks','cp-github'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.value = '';
    });
    const status = document.getElementById('cp-status');
    if (status) status.value = 'ACTIVE';
    const title = document.getElementById('cp-modal-title');
    if (title) title.textContent = 'NEW_PROJECT.EXE';
    const btn = document.getElementById('cp-submit-btn');
    if (btn) { btn.textContent = ''; btn.innerHTML = 'Deploy Project <span class="material-symbols-outlined text-lg">rocket_launch</span>'; btn.onclick = submitCreateProject; }
    openModal('create-project-modal');
}

async function openEditProjectModal(id) {
    try {
        const res = await fetch(`${API_BASE_URL}/projects/${id}`);
        if (!res.ok) { showToast('Failed to load project', 'error'); return; }
        const p = await res.json();
        _editingProjectId = id;
        const el = (eid) => document.getElementById(eid);
        if (el('cp-name'))        el('cp-name').value = p.name || '';
        if (el('cp-description')) el('cp-description').value = p.description || '';
        if (el('cp-tech'))        el('cp-tech').value = (p.techStack || []).join(', ');
        if (el('cp-total-tasks')) el('cp-total-tasks').value = p.totalTasks || 0;
        if (el('cp-github'))      el('cp-github').value = p.githubUrl || '';
        const title = document.getElementById('cp-modal-title');
        if (title) title.textContent = 'EDIT_PROJECT.EXE';
        const btn = document.getElementById('cp-submit-btn');
        if (btn) { btn.innerHTML = 'Save Changes <span class="material-symbols-outlined text-lg">save</span>'; btn.onclick = submitEditProject; }
        openModal('create-project-modal');
    } catch { showToast('Failed to load project', 'error'); }
}

async function submitEditProject() {
    const name        = document.getElementById('cp-name')?.value.trim();
    const description = document.getElementById('cp-description')?.value.trim();
    const techRaw     = document.getElementById('cp-tech')?.value.trim();
    if (!name) { showToast('Project name is required', 'error'); return; }

    const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    try {
        const githubUrl = document.getElementById('cp-github')?.value.trim();
        const res = await fetch(`${API_BASE_URL}/projects/${_editingProjectId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({
                name,
                description,
                techStack: techRaw ? techRaw.split(',').map(t => t.trim()).filter(Boolean) : [],
                githubUrl: githubUrl || ''
            })
        });
        closeModal('create-project-modal');
        if (res.ok) { showToast('Project updated!', 'success'); buildProjects(); }
        else showToast('Failed to update project', 'error');
    } catch { showToast('Connection failed', 'error'); }
}

function deleteProject(id, name) {
    const label = document.getElementById('confirm-delete-label');
    if (label) label.textContent = `"${name}" will be permanently removed. This cannot be undone.`;
    const btn = document.getElementById('confirm-delete-btn');
    if (btn) btn.onclick = async () => {
        closeModal('confirm-delete-modal');
        const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
        try {
            const res = await fetch(`${API_BASE_URL}/projects/${id}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (res.ok) { showToast('Project deleted.', 'success'); buildProjects(); }
            else showToast('Failed to delete project', 'error');
        } catch { showToast('Connection failed', 'error'); }
    };
    openModal('confirm-delete-modal');
}

async function submitCreateProject() {
    const name        = document.getElementById('cp-name')?.value.trim();
    const description = document.getElementById('cp-description')?.value.trim();
    const techRaw     = document.getElementById('cp-tech')?.value.trim();
    const status      = document.getElementById('cp-status')?.value;
    const totalTasks  = parseInt(document.getElementById('cp-total-tasks')?.value) || 0;

    if (!name) { showToast('Project name is required'); return; }

    const githubUrl = document.getElementById('cp-github')?.value.trim();
    const payload = {
        name,
        description,
        techStack: techRaw ? techRaw.split(',').map(t => t.trim()).filter(Boolean) : [],
        status,
        totalTasks,
        completedTasks: 0,
        ...(githubUrl ? { githubUrl } : {})
    };

    try {
        const token = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
        const res = await fetch(`${API_BASE_URL}/projects`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                ...(token ? { 'Authorization': `Bearer ${token}` } : {})
            },
            body: JSON.stringify(payload)
        });
        if (!res.ok) throw new Error('failed');
        closeModal('create-project-modal');
        showToast('Project created successfully');
        buildProjects();
        await _addCoinsToSelf(30, 'project');
    } catch {
        closeModal('create-project-modal');
        showToast('Project submitted — pending backend sync');
        buildProjects();
    }
}

function _renderProjectModal(p, body) {
    const st = _projectStatusTag(p.status);
    const techTags = (p.techStack || []).map(t =>
        `<span class="tag-secondary pf-skill-tag">${t}</span>`
    ).join('');
    const contributions = p.contributions || p.members || [];
    const rows = contributions.map(c => {
        const tasksCompleted = c.tasksCompleted ?? c.completedTasks ?? 0;
        const totalTasks     = c.totalTasks ?? 0;
        const pct = totalTasks ? Math.round((tasksCompleted / totalTasks) * 100) : 0;
        const name = c.memberName ?? c.name ?? '?';
        return `
            <div class="bg-[#111] border border-white/5 p-4">
                <div class="flex items-center justify-between mb-3">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 bg-[#1a1a1a] border border-white/10 flex items-center justify-center font-headline font-bold text-primary text-sm">${name.charAt(0).toUpperCase()}</div>
                        <div>
                            <p class="text-white font-bold text-sm">${name}</p>
                            <p class="font-mono text-[10px] text-gray-500 uppercase">${c.role || ''}</p>
                        </div>
                    </div>
                    <span class="font-mono text-xs text-primary">${tasksCompleted} / ${totalTasks} tasks</span>
                </div>
                <div class="skill-bar">
                    <div class="skill-bar-fill verified" style="width:0%" data-w="${pct}"></div>
                </div>
            </div>`;
    }).join('');
    body.innerHTML = `
        <div class="flex items-start justify-between mb-3">
            <h3 class="font-headline text-2xl font-bold text-white">${p.name}</h3>
            <span class="${st.cls} pf-skill-tag ml-4 shrink-0">${st.label}</span>
        </div>
        <p class="font-mono text-xs text-gray-500 mb-4 leading-relaxed">${p.description || ''}</p>
        <div class="flex flex-wrap gap-2 mb-6">${techTags}</div>
        <div class="mb-5">
            <div class="flex justify-between font-mono text-[10px] mb-1 text-gray-500">
                <span>OVERALL PROGRESS</span><span>${p.completedTasks || 0} / ${p.totalTasks || 0} tasks</span>
            </div>
            <div class="skill-bar">
                <div class="skill-bar-fill verified" style="width:0%" data-w="${p.totalTasks ? Math.round((p.completedTasks / p.totalTasks) * 100) : 0}"></div>
            </div>
        </div>
        <div class="flex items-center gap-2 mb-3">
            <div class="w-3 h-3 bg-primary"></div>
            <span class="font-mono text-[10px] uppercase tracking-widest text-primary">Member Contributions</span>
        </div>
        <div class="space-y-3">${rows || '<p class="font-mono text-xs text-gray-500 text-center py-4">No contribution data yet.</p>'}</div>`;
    _animateProgressBars(body);
}

async function openProjectModal(id) {
    openModal('project-analytics-modal');
    const body = document.getElementById('project-analytics-body');
    body.innerHTML = `<p class="font-mono text-xs text-gray-500 animate-pulse text-center py-10 uppercase tracking-widest">Loading data...</p>`;
    try {
        const response = await fetch(`${API_BASE_URL}/projects/${id}`);
        if (!response.ok) throw new Error('not found');
        const p = await response.json();
        _renderProjectModal(p, body);
    } catch {
        body.innerHTML = `<p class="font-mono text-xs text-red-400 text-center py-10">[ Failed to load project data ]</p>`;
    }
}

let _selectedProjectId = null;
let _selectedProjectName = null;

async function openProjectPickerModal() {
    const modal = document.getElementById('project-picker-modal');
    const list = document.getElementById('project-picker-list');
    const confirmBtn = document.getElementById('project-picker-confirm');
    if (!modal || !list) return;

    _selectedProjectId = null;
    _selectedProjectName = null;
    if (confirmBtn) { confirmBtn.disabled = true; confirmBtn.classList.add('opacity-40','cursor-not-allowed'); }

    modal.classList.remove('hidden');
    list.innerHTML = '<p class="text-gray-500 font-mono text-xs text-center animate-pulse">Loading projects...</p>';

    try {
        const res = await fetch(`${API_BASE_URL}/projects`);
        const projects = res.ok ? await res.json() : STATIC_PROJECTS;
        const active = projects.filter(p => (p.status||'').toUpperCase() !== 'COMPLETED');
        if (!active.length) { list.innerHTML = '<p class="text-gray-500 font-mono text-xs text-center">No active projects available.</p>'; return; }
        list.innerHTML = active.map(p => `
            <div onclick="selectProjectPitch(${p.id}, '${(p.name||'').replace(/'/g,"\\'")}', this)"
                class="project-pick-item border border-white/10 p-4 cursor-pointer hover:border-primary/50 transition-all">
                <div class="flex items-start justify-between gap-3">
                    <div>
                        <p class="font-headline font-bold text-white text-sm">${p.name}</p>
                        <p class="font-mono text-[10px] text-gray-500 mt-1 line-clamp-2">${p.description || '—'}</p>
                    </div>
                    <span class="font-mono text-[9px] uppercase px-2 py-1 border border-primary/30 text-primary shrink-0">${p.status || 'ACTIVE'}</span>
                </div>
                <div class="flex flex-wrap gap-1.5 mt-2">${(p.techStack||[]).slice(0,4).map(t=>`<span class="tag-secondary pf-skill-tag">${t}</span>`).join('')}</div>
            </div>`).join('');
    } catch {
        list.innerHTML = STATIC_PROJECTS.map(p => `
            <div onclick="selectProjectPitch(${p.id}, '${(p.name||'').replace(/'/g,"\\'")}', this)"
                class="project-pick-item border border-white/10 p-4 cursor-pointer hover:border-primary/50 transition-all">
                <p class="font-headline font-bold text-white text-sm">${p.name}</p>
                <p class="font-mono text-[10px] text-gray-500 mt-1">${p.description || '—'}</p>
            </div>`).join('');
    }
}

function selectProjectPitch(id, name, el) {
    _selectedProjectId = id;
    _selectedProjectName = name;
    document.querySelectorAll('.project-pick-item').forEach(i => i.classList.remove('border-primary','bg-primary/5'));
    el.classList.add('border-primary','bg-primary/5');
    const confirmBtn = document.getElementById('project-picker-confirm');
    if (confirmBtn) { confirmBtn.disabled = false; confirmBtn.classList.remove('opacity-40','cursor-not-allowed'); }
    const label = document.getElementById('project-picker-selected-label');
    if (label) label.innerHTML = `<span class="text-primary">Selected:</span> ${name}`;
}

function closeProjectPickerModal() {
    const modal = document.getElementById('project-picker-modal');
    if (modal) modal.classList.add('hidden');
}

function confirmProjectPitch() {
    if (!_selectedProjectName) return;
    closeProjectPickerModal();
    const btn = document.getElementById('btn-register-incubator');
    if (btn) { btn.disabled = true; btn.textContent = '✓ Pitched'; btn.classList.add('opacity-60','cursor-not-allowed'); }
    showToast(`Pitch submitted for "${_selectedProjectName}"! Our team will review it soon.`, 'success');
}
