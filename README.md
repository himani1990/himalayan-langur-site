# Himalayan Langur Project Website

Static website for the Himalayan Langur Project.

## Deployment Type

This is a plain static website.

- Build command: none
- Local entry file: `index.html`
- Website assets: `assets/`
- GitHub Pages deployment output: `_site`, created by the GitHub Actions workflow

The deployment workflow is in `.github/workflows/pages.yml`. It copies only the website files into `_site`:

- `index.html`
- `styles.css`
- `assets/`

This avoids publishing unrelated analysis, report, or backup files that may also exist in the repository.

## Publish on GitHub Pages

1. Push this repository to GitHub on the `main` branch.
2. In GitHub, open the repository.
3. Go to **Settings > Pages**.
4. Under **Build and deployment**, set **Source** to **GitHub Actions**.
5. Open the **Actions** tab and run or wait for **Deploy GitHub Pages**.
6. After it finishes, GitHub will show the default Pages URL.

Test the default GitHub Pages URL first before changing GoDaddy DNS.

## Custom Domain Later

The current GitHub Actions deployment does not publish a `CNAME` file. This is intentional so the site can be tested first at the default GitHub Pages URL.

When ready to use the custom domain:

1. Create or keep a root-level `CNAME` file containing:

   ```text
   himalayanlangur.com
   ```

2. In `.github/workflows/pages.yml`, add this line under the `Prepare static site` step, after `cp -R assets _site/assets`:

   ```bash
   cp CNAME _site/CNAME
   ```

3. In GitHub, go to **Settings > Pages** and add the custom domain:

   ```text
   himalayanlangur.com
   ```

4. In GoDaddy DNS, configure these records:

   ```text
   Type  Name  Value
   A     @     185.199.108.153
   A     @     185.199.109.153
   A     @     185.199.110.153
   A     @     185.199.111.153
   AAAA  @     2606:50c0:8000::153
   AAAA  @     2606:50c0:8001::153
   AAAA  @     2606:50c0:8002::153
   AAAA  @     2606:50c0:8003::153
   CNAME www   himani1990.github.io
   ```

5. After DNS finishes updating, enable **Enforce HTTPS** in GitHub Pages settings.

Do not cancel the domain registration itself. Only cancel the old Squarespace website plan after the GitHub Pages site and GoDaddy DNS are working.

## Updating The Website

To update text:

1. Edit `index.html`.
2. Save the file.
3. Commit and push to GitHub.
4. GitHub Actions will redeploy automatically.

To update styling:

1. Edit `styles.css`.
2. Commit and push.

To add images:

1. Put optimized images in `assets/images/`.
2. Reference them from `index.html`.
3. Keep image filenames simple, for example `mandal-valley.jpg`.

To add gallery images:

1. Put the image in `assets/images/gallery/`.
2. Copy one existing gallery `<figure>` block in `index.html`.
3. Change the `src` and `alt` text.

To replace the gallery video:

1. Put the new MP4 file in `assets/videos/`.
2. Either name it `gallery-drone.mp4`, or update the video source in `index.html`.
3. Keep the video compressed for web use.

## Local Preview

Open `index.html` in a browser, or use a simple local server:

```bash
python3 -m http.server 8000
```

Then open:

```text
http://localhost:8000
```
