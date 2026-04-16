# MyST Blog Template

A reusable template for building blog websites with [MyST Markdown](https://mystmd.org/), RSS/Atom feed generation, tag-based navigation, and automated deployment via GitHub Actions.

## Features

- **MyST Markdown** source format with Jupyter notebook integration
- **Blog** with RSS and Atom feed generation
- **Tag-based navigation** in the sidebar for browsing posts by topic
- **Giscus comments** (GitHub-backed) for blog posts
- **GitHub Pages** deployment on push to `main`
- **Netlify PR previews** for pull request review
- **Pre-commit hooks**: Black, codespell, nbstripout for code quality

## Quick Start

1. Click **Use this template** on GitHub to create a new repository
2. Update `myst.yml` with your site title, description, and table of contents
3. Replace sample posts in `posts/` with your own
4. Add or update tag pages in `tags/` to match your post tags
5. Update `generate_rss.py` with your site URL and metadata
6. Push to GitHub to trigger automated builds

## Project Structure

```
.
├── myst.yml                    # MyST configuration
├── index.md                    # Landing page (blog post gallery)
├── custom.css                  # Custom CSS styling
├── requirements.txt            # Python dependencies
├── generate_rss.py             # RSS/Atom feed generation script
├── inject_comments.py          # Giscus comment injection script
├── Dockerfile                  # Docker build for full site
├── logo.png                    # Site logo
├── fav.ico                     # Favicon
├── CNAME                       # Custom domain (optional)
├── posts/                      # Blog posts
│   ├── sample-post.md          # Sample blog post
│   └── images/                 # Shared images
├── tags/                       # Tag pages (sidebar navigation)
│   ├── myst-markdown.md        # Posts tagged "MyST Markdown"
│   ├── tutorial.md             # Posts tagged "Tutorial"
│   └── github-pages.md         # Posts tagged "GitHub Pages"
├── .pre-commit-config.yaml     # Pre-commit hook configuration
├── CONTRIBUTING.md             # Contribution guidelines
├── CONDUCT.md                  # Code of conduct
└── .github/workflows/
    ├── build.yml               # PR preview builds (Netlify)
    └── deploy.yml              # Production deployment (GitHub Pages)
```

## Customization

### Site Metadata

Edit `myst.yml`:

- `project.title`: your blog name
- `project.description`: site description
- `project.keywords`: your blog keywords
- `site.parts.footer`: footer links (social profiles)

### Adding Blog Posts

1. Create a new `.md` file in `posts/` with frontmatter (title, date, authors, description, tags)
2. Add a card entry in `index.md` linking to the new post
3. Update relevant tag pages in `tags/` to include the new post

### Adding Tags

1. Create a new `.md` file in `tags/` with a card grid listing posts for that tag
2. Add the file to `project.toc` under the Tags section in `myst.yml`

## Building Locally

### Build HTML

```bash
pip install -r requirements.txt
npm install -g mystmd
myst build --html
```

The built site will be in `_build/html/`.

### Generate RSS/Atom Feeds

```bash
pip install feedgen pyyaml
python generate_rss.py
```

Reads frontmatter from `posts/*.md` and writes `rss.xml` and `atom.xml`.

### Building with Docker

Build and serve the site without installing any dependencies locally:

```bash
docker build -t myst-blog-template .
docker run --rm -p 3000:3000 -p 3100:3100 myst-blog-template
```

Then open http://localhost:3000 in your browser. If port 3000 is already in use, map to different ports (e.g., `-p 3001:3000 -p 3101:3100` and open http://localhost:3001).

## Deployment

### GitHub Pages (production)

Pushes to `main` trigger the `deploy.yml` workflow, which:

1. Builds the HTML site with MyST
2. Generates `rss.xml` and `atom.xml` from blog posts
3. Deploys everything to GitHub Pages

### Netlify (PR previews)

Pull requests trigger the `build.yml` workflow for preview deployments. Requires `NETLIFY_AUTH_TOKEN` and `NETLIFY_SITE_ID` secrets.

## Enabling Giscus Comments

[Giscus](https://giscus.app/) adds a GitHub-backed comment section to each blog post. To enable it:

1. Go to [giscus.app](https://giscus.app/) and follow the configuration steps for your repository
2. Enable **GitHub Discussions** on your repository (Settings > General > Features > Discussions)
3. Open `inject_comments.py` and replace the placeholder values with your Giscus configuration:
   - `data-repo`: your `username/repo`
   - `data-repo-id`: your repository ID (provided by giscus.app)
   - `data-category`: the Discussions category to use (e.g., `General`)
   - `data-category-id`: the category ID (provided by giscus.app)
4. The repository includes a custom `giscus-light.css` theme for light mode. `inject_comments.py` copies it into `_build/html/` during deployment and keeps dark mode on Giscus's built-in dark theme.
5. The `deploy.yml` workflow already runs `python inject_comments.py` during deployment, so comments will appear on the next push to `main`

## GitHub Secrets

| Secret | Purpose |
|--------|---------|
| `NETLIFY_AUTH_TOKEN` | Netlify authentication for PR previews |
| `NETLIFY_SITE_ID` | Netlify site ID for PR previews |

## License

[MIT](LICENSE)
