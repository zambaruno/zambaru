# LOST web client for zambaru.com

This is a browser client for the existing `zambaruno-lost` Supabase project.
It uses only its publishable key and the existing `finds`, `claims`, and
`storage/finds` policies. No schema changes, new public grants, or service-role
keys are required. Real finds, uploads and private claims require sign-in in
this client, consistent with the current mobile interface.

## Build

Run `npm ci`, `npm test`, and `npm run build` in this directory. Copy `dist/`
to the repository root. Both third-party browser packages are pinned and
bundled locally; the browser does not download scripts from a CDN.

The main website still has eight interface languages. Posters have sixteen
languages and a locally generated QR containing exactly `https://zambaru.com`.
Printing uses the browser's print/PDF dialog. The film is a photograph
slideshow of actual finds, with play, pause, previous, next and speed controls.

## Google web callback — unfinished external configuration

The current Supabase Auth redirect configuration falls back to
`com.zambaruno.lost://login-callback/`. The mobile callback must be preserved.
Add `https://zambaru.com/lost-app` to Authentication → URL Configuration →
Redirect URLs. Do not replace the existing mobile callback or change provider
secrets. Then set `googleWebReady` to `true` in `public-config.json`, rebuild,
and test a real Google sign-in and return to the website. Until then the web
Google button is explicitly unavailable, rather than opening the mobile app.
Do not claim authenticated uploads or messaging have been tested against
production until this sign-in has been completed.

## Payments

No verified donation/checkout receiving URL has been supplied. Support
currently offers sharing, copying the link and printing posters; it says
clearly that no money is being collected. Do not invent a payment recipient
or treat opening a checkout page as confirmation of payment.

## Validation

Automated tests cover route destinations, translations, sign-in gating,
feed errors, safe text rendering, slideshow controls, photo validation,
ownership rules and the QR payload. UI integration tests use a mock client
and make no production writes. Live read-only checks of the project API are
separate. Keep the Google callback and donation limitations visible.
