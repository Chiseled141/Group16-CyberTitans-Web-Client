function openPassModal() {
    document.getElementById('password-modal').classList.remove('hidden');
}

function closePassModal() {
    document.getElementById('password-modal').classList.add('hidden');
    document.getElementById('old-pass').value = '';
    document.getElementById('new-pass').value = '';
}

async function submitChangePassword() {
    const oldPass = document.getElementById('old-pass').value;
    const newPass = document.getElementById('new-pass').value;

    if (!oldPass || !newPass) {
        return showToast('Please fill in all fields.', 'error');
    }

    const token          = sessionStorage.getItem('cyber_token') || localStorage.getItem('cyber_token');
    const currentUserStr = sessionStorage.getItem('cyber_user')  || localStorage.getItem('cyber_user');

    if (!token || !currentUserStr) {
        return showToast('Authentication error. Please log in again.', 'error');
    }

    const currentUser = JSON.parse(currentUserStr);

    try {
        const response = await fetch(`${API_BASE_URL}/auth/change-password`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify({
                username:    currentUser.username,
                oldPassword: oldPass,
                newPassword: newPass
            })
        });

        if (response.ok) {
            showToast('Password changed successfully!', 'success');
            closePassModal();
        } else {
            const data = await response.json();
            showToast(data.message || 'Old password is incorrect.', 'error');
        }
    } catch {
        showToast('Connection error. Please try again later.', 'error');
    }
}
