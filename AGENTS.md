# AGENTS.md

Hugo blog (Noise From the Basement), mid-migration from WordPress to
Cloudflare Workers (static assets, not Pages). Theme is Beautiful Hugo.

## Tooling — Docker only

Hugo and Python/Pillow are NOT installed on the host. Use docker compose:

- Dev server (live reload, http://localhost:1313): `docker compose up hugo`
- Production build into `./public`: `docker compose run --rm build`
- Convert content images to WebP: `docker compose run --rm optimize-images` (`--dry-run` to preview)

Hugo version is pinned in `docker-compose.yml`; keep the two services in sync
if you bump it.

## Deploy (`.github/workflows/deploy.yml`)

One workflow handles both cases: push to `main` runs `wrangler deploy`
(production); PRs run `wrangler versions upload --preview-alias <alias>`,
which never touches production. Non-obvious details:

- The preview alias is the branch name sanitized to a DNS label (lowercase
  alphanumerics/hyphens, 40 chars max) because it becomes the hostname
  `<alias>-nftb.saturdaymp.workers.dev`. PR builds pass that URL as
  `--baseURL` so absolute links stay on the preview.
- CI runs the Hugo container with `-u root`: the image's uid 1000 can't
  write to the runner-owned workspace.
- Args after the compose service name replace the whole `command`, so
  `--minify` must be repeated when passing extra flags to `build`.
- The worker serves `./public` as static assets only (`wrangler.jsonc`) —
  there is no worker script.
- Required repo secrets: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`.

## Non-obvious rules

- Beautiful Hugo is a Hugo Module (see `go.mod`/`go.sum`), pinned by version — there
  is no theme code in the repo. Do not edit theme files — override templates in
  the top-level `layouts/` directory instead. Update with
  `docker compose run --rm --entrypoint hugo build mod get -u ./...`.
- `public/` is generated output and gitignored. Never edit or commit it.
- Post URLs must keep the old WordPress permalinks, which are flat: the slug
  at the site root (`/slug/`), no date. `[permalinks.page]` in `hugo.toml`
  maps `posts` and `pages` to `/:contentbasename/` — the bundle directory
  name is the WordPress slug, so the URL comes from the directory, never from
  a `slug` in front matter. Don't add a `slug` and don't rename bundle
  directories; either one breaks an existing link.
- Posts are page bundles at `content/posts/YYYY/MM/slug/index.md` with images
  beside the markdown. The `YYYY/MM` is organizational only — it doesn't
  appear in the URL — but keep it so bundles stay grouped.
- Drafts live in `content/posts/_drafts/id-NNNN/index.md` with `draft: true`
  and no date; the NNNN is the original WordPress post ID.
- `backup/`, `plan.txt`, and `noisefromthebasement.WordPress.*.xml` are
  temporary migration artifacts (gitignored). Don't build on them; they will
  be deleted once the migration is verified.
- Front matter uses `categories` and `tags` lists (WordPress taxonomies
  carried over) — reuse existing values rather than inventing new ones.
