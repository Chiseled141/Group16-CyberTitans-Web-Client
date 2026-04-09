async function buildFaqAndPolicies() {
    const container = document.getElementById('faq-container');
    if (!container) return;

    try {
        const res   = await fetch(`${API_BASE_URL}/policies?type=1`);
        const faqs  = await res.json();

        container.innerHTML = faqs.map((item, idx) => `
            <div class="border border-white/5 bg-[#0a0a0a] hover:border-secondary/20 transition-all">
                <button onclick="toggleFaq(${idx})" class="w-full flex items-center justify-between px-6 py-4 text-left group">
                    <span class="font-bold text-sm text-white group-hover:text-secondary transition-colors pr-4">${item.title}</span>
                    <span id="faq-icon-${idx}" class="text-secondary font-mono text-xl flex-shrink-0">+</span>
                </button>
                <div id="faq-answer-${idx}" class="hidden px-6 pb-4">
                    <p class="text-on-surface-variant text-sm leading-relaxed font-mono">${item.content || ''}</p>
                </div>
            </div>`).join('');

    } catch (err) {
        console.error('FAQ error:', err);
    }
}

function toggleFaq(index) {
    const ans  = document.getElementById(`faq-answer-${index}`);
    const icon = document.getElementById(`faq-icon-${index}`);
    ans.classList.toggle('hidden');
    icon.textContent = ans.classList.contains('hidden') ? '+' : '-';
}
