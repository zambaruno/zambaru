# Mobile-approved desktop sign-in (approved 2026-10-28)

Status: approved product requirement; implementation and end-to-end tests pending.

## User experience
- Accounts are created in the mobile application. A desktop browser may sign in to an existing account by scanning a short-lived QR challenge with the signed-in mobile app and explicitly approving the browser/device name.
- Successful approval establishes a persistent browser session for **30 days of inactivity**, sliding forward on legitimate activity. Do not require another QR scan on routine return visits. A cleared browser profile, explicit logout, revoked device, or security event requires reauthentication.
- Users may review and revoke individual browser sessions or all browser sessions from the mobile app. All registered items, photos, and history are tied to the account, not to the browser session.
- The same workflow applies to Zambaru/LOST and Zambaruno Free Diagnostic, but keep their account namespaces and authorization scopes separate unless a separate account-linking decision is approved.

## Security and backend contract
1. Browser calls authenticated backend endpoint POST /desktop-login/challenges (no account needed), receives an opaque random challenge id and expiry, and displays QR containing a canonical HTTPS link with that id. Expiry <= 120 seconds.
2. Mobile app scans the challenge, validates the HTTPS origin and challenge status, displays requested browser/device and project, then sends approval using its existing authenticated session. Scanning alone must not authorize a login.
3. Backend atomically marks challenge consumed, binds it to the approving user's project-specific identity, and allows only the initiating browser (via a separate HttpOnly SameSite Secure browser-binding cookie) to exchange it for a session. Never embed an access token, password, or user id in the QR.
4. Backend issues a short-lived access session plus rotating refresh credentials stored as Secure HttpOnly cookies. Server-side session record includes account id, project, device label, last_activity_at, idle_expires_at, revoked_at, and hashed refresh token; set idle_expires_at = last_activity_at + 30 days on validated activity, with throttled DB writes.
5. Refresh tokens rotate atomically; detect replay, revoke compromised token families; enforce CSRF protections for cookie-based state-changing requests, rate limits, origin checks, TLS, no-store responses, and audit logging. Never store refresh tokens in localStorage.
6. Reject revoked, expired, mismatched-project, or idle-expired sessions on every refresh. Browser session must be scoped to the correct site/domain and not silently shared with other projects.
7. Provide mobile endpoints for list/revoke browser sessions, and revoke-all. Use existing identity provider/session verification rather than trusting client-provided user IDs.

## Acceptance tests
- First QR approval signs in only the requesting browser; second scan/replay fails.
- Returning in same browser within 30 days needs no QR; validated activity extends inactivity expiry.
- At 30 days without activity, session is rejected and a new QR is needed.
- Logout, phone revocation, and refresh-token replay invalidate the browser session.
- Incognito/cleared cookies require QR; another browser/device does not inherit authorization.
- Two project identities cannot be crossed; registered data remains intact after expiry.

Do not claim this feature is deployed until server, website, mobile UI, migrations and tests have been completed and verified.
