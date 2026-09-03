# Noise From the Basement (NFTB) Blog

[![Deploy](https://github.com/saturdaymp/nftb/actions/workflows/deploy.yml/badge.svg)](https://github.com/saturdaymp/nftb/actions/workflows/deploy.yml)
[![Sponsor](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=fe8e86)](https://github.com/sponsors/saturdaymp)

Source for [Noise From the Basement](https://nftb.saturdaymp.workers.dev/), a
static blog built with [Hugo](https://gohugo.io/) and the
[Beautiful Hugo](https://github.com/halogenica/beautifulhugo) theme, hosted on
Cloudflare Workers (static assets). The content was [migrated](https://www.youtube.com/playlist?list=PLOaCY0HmoDNU) from a
WordPress site.

## Running locally

Nothing needs to be installed on your machine except Docker — Hugo runs in a
container (version pinned in `docker-compose.yml`).

```sh
# Dev server with live reload and drafts at http://localhost:1313
docker compose up hugo

# One-off production build into ./public (gitignored — never commit it)
docker compose run --rm build
```

## How the deploy works

Everything is in [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml):

- **Push to `main`** — builds the site with Hugo (in Docker, same image as
  local) and runs `wrangler deploy`, which uploads `./public` as static
  assets to the `nftb` Cloudflare Worker (config in `wrangler.jsonc`).
  Production URL: <https://nftb.saturdaymp.workers.dev/>.
- **Pull requests** — same build, but deployed with
  `wrangler versions upload --preview-alias <branch>`, which publishes a
  preview version at `https://<branch>-nftb.saturdaymp.workers.dev/` without
  touching production. The site is built with `--baseURL` set to the preview
  URL so absolute links stay on the preview. The workflow posts (and keeps
  updated) a single PR comment with the preview link.

The workflow needs two repository secrets: `CLOUDFLARE_API_TOKEN` and
`CLOUDFLARE_ACCOUNT_ID`.

## Content layout

Post URLs must keep the old WordPress permalink structure, so **don't move or
rename posts**. Each post is a page bundle with its images beside the
markdown:

```
content/posts/YYYY/MM/slug/index.md   # published post
content/posts/_drafts/id-NNNN/        # draft (draft: true, no date;
                                      # NNNN = original WordPress post ID)
content/pages/                        # standalone pages
```

Front matter uses `categories` and `tags` lists carried over from WordPress —
reuse existing values rather than inventing new ones.

### Images

Content images are converted to WebP by a helper script (Pillow runs inside a
container, nothing to install):

```sh
docker compose run --rm optimize-images            # convert everything
docker compose run --rm optimize-images --dry-run  # preview, no changes
```

## Theme

Beautiful Hugo is a Hugo Module pinned in `go.mod`/`go.sum` — there is no theme
code in this repo. Never edit theme files; override templates by placing
files in the top-level `layouts/` directory. To update the theme:

```sh
docker compose run --rm --entrypoint hugo build mod get -u ./...
```