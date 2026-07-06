# AGENTS.md

Hugo blog (Noise From the Basement), mid-migration from WordPress to
Cloudflare Pages. Theme is PaperMod.

## Tooling — Docker only

Hugo and Python/Pillow are NOT installed on the host. Use docker compose:

- Dev server (live reload, http://localhost:1313): `docker compose up hugo`
- Production build into `./public`: `docker compose run --rm build`
- Convert content images to WebP: `docker compose run --rm optimize-images` (`--dry-run` to preview)

Hugo version is pinned in `docker-compose.yml`; keep the two services in sync
if you bump it.

## Non-obvious rules

- PaperMod is a Hugo Module (see `go.mod`/`go.sum`), pinned by version — there
  is no theme code in the repo. Do not edit theme files — override templates in
  the top-level `layouts/` directory instead. Update with
  `docker compose run --rm --entrypoint hugo build mod get -u ./...`.
- `public/` is generated output and gitignored. Never edit or commit it.
- Post URLs must keep the old WordPress permalink structure. Posts are page
  bundles at `content/posts/YYYY/MM/slug/index.md` with images beside the
  markdown — don't restructure paths or slugs.
- Drafts live in `content/posts/_drafts/id-NNNN/index.md` with `draft: true`
  and no date; the NNNN is the original WordPress post ID.
- `backup/`, `plan.txt`, and `noisefromthebasement.WordPress.*.xml` are
  temporary migration artifacts (gitignored). Don't build on them; they will
  be deleted once the migration is verified.
- Front matter uses `categories` and `tags` lists (WordPress taxonomies
  carried over) — reuse existing values rather than inventing new ones.
