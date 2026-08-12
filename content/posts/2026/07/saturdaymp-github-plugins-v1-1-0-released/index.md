---
title: "SaturdayMP GitHub Plugins v1.1.0 Released!"
author: "Chris C"
date: 2026-07-10T16:28:49
categories: 
  - "releases"
tags: 
  - "claudeplugins"
  - "releases"
---

I'm happy to announce that [v1.1.0](https://github.com/saturdaymp/claude-plugins/releases/tag/v1.1.0) of the [SaturdayMP GitHub Plugins](https://github.com/saturdaymp/claude-plugins) was released today! You can install it in Claude Code by first installing the marketplace:

```text
/plugin marketplace add saturdaymp/claude-plugins
```

Then pick v1.1.0 of the plugin:

```text
/plugin install smp-github@saturdaymp-claude-plugins
```

If you want to live on the bleeding edge by installing:

```text
/plugin install smp-github-latest@saturdaymp-claude-plugins
```

The plugin has two skills. I use the PR feedback one all the time. Not sure how useful the change log skill will be. Maybe move it outside the plugin?

- [smp-apply-github-pr-feedback](https://github.com/saturdaymp/claude-plugins/blob/main/plugins/smp-github/README.md#smp-apply-github-pr-feedback) — evaluate a PR review comment, fix it if valid, commit, reply, and resolve the conversation.
- [smp-create-gh-changelog-script](https://github.com/saturdaymp/claude-plugins/blob/main/plugins/smp-github/README.md#smp-create-gh-changelog-script) — create a standalone bash script that generates a CHANGELOG.md from GitHub releases.

The plugin might work with other coding agents, but I haven't tried. If you do try them in a different agent, let me know the results, good or bad.

Feel free to ask questions in the [discussions](https://github.com/orgs/saturdaymp/discussions) or open an [issue](https://github.com/saturdaymp/claude-plugins/issues). Happy coding!
