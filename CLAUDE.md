# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A bilingual (Japanese/English) blog site built with Hugo (extended version), deployed on Cloudflare Pages.

## Development Commands

### Local Development
```bash
hugo server          # Start development server with live reload
hugo server -D       # Include draft posts
```

### Build
```bash
hugo                 # Build site to public/ directory
hugo --minify        # Build with minification
```

### Create New Content
```bash
hugo new en/posts/slug/index.md        # New English post
hugo new ja/posts/slug/index.md        # New Japanese post
```

## Architecture

### Directory Structure
- `content/`: Content files (Markdown)
  - `en/posts/`: English posts (Page Bundles)
  - `en/history.md`: English history page
  - `ja/posts/`: Japanese posts (Page Bundles)
  - `ja/history.md`: Japanese history page
- `layouts/`: Hugo templates
  - `_default/`: Default templates (baseof.html, list.html, single.html)
  - `partials/`: Reusable template parts
  - `posts/`: Post-specific templates
- `assets/css/`: CSS files (processed by Hugo Pipes)
- `static/`: Static files copied as-is
  - `_redirects`: Cloudflare Pages redirects
  - `icon.png`: Favicon
  - `images/`: Profile images
- `archetypes/`: Content templates

### Key Components

**Hugo Configuration** (`hugo.toml`)
- Multilingual setup (en default, ja)
- Permalink structure: `/posts/:year/:month/:slug/`
- Monokai syntax highlighting
- RSS feed generation

**Templates**
- `layouts/_default/baseof.html`: Base HTML structure
- `layouts/partials/profile.html`: Profile partial with language-aware content
- `layouts/partials/language-switcher.html`: Language toggle

**Content Organization (Page Bundles)**
- Posts are organized as Page Bundles: `posts/YYYY/slug/index.md`
- Images for posts are stored in the same directory
- Front matter: title, date, slug

### URL Structure
- English: `/posts/YYYY/MM/slug/`
- Japanese: `/ja/posts/YYYY/MM/slug/`
- History: `/history/`, `/ja/history/`
- RSS: `/index.xml`, `/ja/index.xml`

### Redirects
Legacy URLs are redirected via `static/_redirects`:
- `/blog/*` → `/ja/posts/*`
- `/feed.xml` → `/index.xml`

## GitHub Actions

**Deployment** (`.github/workflows/deploy.yml`)
- Build with Hugo extended
- Deploy to Cloudflare Pages on main branch

## Requirements

- Hugo extended version (0.155.2, pinned in `.tool-versions`)
- Use asdf/mise with `.tool-versions`
