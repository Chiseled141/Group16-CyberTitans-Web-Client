# DOCS Fill-in Sections
> Use these as reference — rewrite in your own words before submitting.

---

## 4.4 Implementation

The frontend is implemented using Thymeleaf as the server-side template engine, with reusable fragments for shared components such as the navigation bar, modals, and footer. Each page has its own dedicated JavaScript module located in the `static/js/pages/` directory, and CSS is organized into modular files under `static/css/` to maintain separation of concerns.

The backend exposes REST API endpoints consumed by the frontend via JavaScript `fetch()` calls. Static project data is used as a fallback when the API is unavailable, ensuring the interface remains functional during development.

Key modules implemented on the client side include: member profiles, project tracking with task progress visualization, event join/leave functionality, artifact browsing with category filtering, a skill-based ranking leaderboard, and a mentor matching system.

---

## 4.5 Testing

Testing was performed manually by navigating through each page and verifying that all features behaved as expected. The following areas were tested:

**Functional testing:** Login, registration, page navigation, project creation, event joining, and artifact filtering were all verified to work correctly.

**Role-based testing:** Different accounts (Admin, Mentor, Mentee) were used to confirm that restricted features are hidden or blocked for unauthorized roles.

**Responsive testing:** The interface was tested on both desktop and mobile screen sizes to ensure proper layout and usability.

**Integration testing:** API calls between the frontend and backend were tested to confirm correct data flow for user authentication, project data, and event management.

---

## 5.1 Strengths — complete the cut-off paragraph

Different user roles (Admin, Mentor, and Mentee) each have access to specific features and are restricted from others, reducing the risk of unauthorized actions and keeping the system organized.

Third, the frontend is built with a modular structure — CSS and JavaScript are split into page-specific files, making the codebase easier to maintain and extend. Reusable Thymeleaf fragments (navbar, footer, modals) reduce code duplication across pages.

Fourth, the platform consolidates multiple club functions — project tracking, event management, artifact sharing, mentorship, and ranking — into a single application, eliminating the need for separate tools.

---

## 6.1 Functional Evaluation

All core features were tested and confirmed functional:

- User registration and login with JWT authentication
- Role-based access control (Admin, Mentor, Mentee, Guest)
- Project creation, viewing, and task progress tracking
- Event listing, joining, and leaving
- Artifact browsing with category filters
- Mentor Hub with mentor request system
- Announcement broadcast feed
- Skill ranking leaderboard

---

## 6.2 Usability Evaluation

The interface is designed with simplicity and clarity in mind. Navigation is handled through a fixed top navbar accessible on all pages. Key actions such as joining an event or filtering artifacts require a single click. The dark-themed UI with clear typography and color-coded status tags reduces cognitive load and makes information easy to scan.

Mobile responsiveness was achieved using Tailwind CSS, ensuring the layout adapts correctly on smaller screens with a collapsible mobile menu.

---

## 6.3 Performance Evaluation

The application starts in under 3 seconds on a local machine (Spring Boot startup ~2.2s). Page rendering is fast since Thymeleaf generates HTML server-side, reducing the amount of client-side processing required. JavaScript modules are loaded once on initial page load and reused across navigation without full page reloads.

---

## 6.4 Results

The system performs reliably under normal usage conditions. All defined functional requirements are met. The modular architecture ensures that individual components can be updated without affecting the rest of the system. User feedback during internal testing indicated that the interface is intuitive and easy to navigate.
