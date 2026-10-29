ZAMBARU / LOST WEBSITE

The main page at https://zambaru.com/ is the LOST lost-and-found landing page.
It uses assets/home-v3.css, assets/home-v3.js and the actual LOST emblem.
The page and download instructions support English, Spanish, German, Arabic, Chinese, Russian, Azerbaijani and French.

Main routes:
- /: LOST homepage, browser entry, installation entry, guide and poster links.
- /lost-app: existing LOST browser application; its data/auth implementation is preserved.
- /lost-guide: existing LOST guide.
- /lost/download/: permanent installation information and current APK link.
- /downloads/lost.apk: Cloudflare Pages 302 redirect to the tested APK in permanent public object storage.
- /projects/: secondary Zambaruno projects, author information and blog placeholder.
- /inventions/dispenser/: existing dispenser project, preserved.

APK publishing:
The APK is stored in R2 behind a public binary-only download host, outside expiring Actions artifacts.
Host: https://lost-android-downloads.frosty-tick-7668.chatgpt.site/LOST-68.apk
Build: 68; size: 96799541 bytes.
SHA-256: c43b2ddaf231a3f74bc5c721e3ee7d76d2fc73adc99805a4e75269197f63f55d
The imported bytes were checked against that checksum. The GitHub app repository stays private.
The temporary import credential was removed after the object was saved.
Updating _redirects changes the APK target without changing the public download address.
Do not point this route at an untested build or at an Actions run.

This is Android test build 68 for ARM64. There is no native iPhone download.
The earlier test builds did not preserve a fixed signing certificate. Keep the installation
notice until permanent app signing has been set up and verified across consecutive builds.

Deploy the repository root as the static Cloudflare Pages directory.
Cloudflare Pages consumes _redirects; a generic local file server does not execute it.
robots.txt and sitemap.xml advertise the public information pages. Indexing is not guaranteed.

The homepage shows a direct Zambaruno Diagnostic panel below the LOST header, with the free diagnostic invitation in all eight Zambaru languages. The linked Diagnostic site manages its own language choices.
