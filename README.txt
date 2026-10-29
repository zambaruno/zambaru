ZAMBARU / LOST WEBSITE

The main page at https://zambaru.com/ is the LOST lost-and-found landing page.
It uses assets/home.css, assets/home.js and the actual LOST emblem.
The page and download instructions support English, Russian, Spanish and Turkish.

Main routes:
- /: LOST homepage, browser entry, installation entry, guide and poster links.
- /lost-app: existing LOST browser application; its data/auth implementation is preserved.
- /lost-guide: existing LOST guide.
- /lost/download/: permanent installation information and current APK link.
- /downloads/lost.apk: Cloudflare Pages 302 redirect to the tested public GitHub release asset.
- /projects/: secondary Zambaruno projects, author information and blog placeholder.
- /inventions/dispenser/: existing dispenser project, preserved.

APK publishing:
The APK is hosted as a public GitHub release asset, outside expiring Actions artifacts.
The initial release is android-build-68 in zambaruno/lost, asset LOST-68.apk.
The matching publish-tested-download workflow verifies the APK SHA-256 before uploading.
Updating _redirects changes the APK target without changing the public download address.
Do not point this route at an untested build or at an Actions run.

This is Android test build 68 for ARM64. There is no native iPhone download.
The earlier test builds did not preserve a fixed signing certificate. Keep the installation
notice until permanent app signing has been set up and verified across consecutive builds.

Deploy the repository root as the static Cloudflare Pages directory.
Cloudflare Pages consumes _redirects; a generic local file server does not execute it.
robots.txt and sitemap.xml advertise the public information pages. Indexing is not guaranteed.
