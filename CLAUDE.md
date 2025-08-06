# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A bilingual (Japanese/English) blog site built with Rails 8.0.2, using Parklife for static site generation and hosted on GitHub Pages.

## Development Commands

### Local Development
```bash
bin/rails server      # Start development server
bin/rails console     # Rails console
```

### Testing
```bash
bundle exec rspec                  # Run all tests
bundle exec rspec spec/models      # Run model tests only
bundle exec rspec spec/system      # Run system tests only
bundle exec rspec spec/path/to/specific_spec.rb  # Run specific test file
```

### Static Site Build
```bash
bin/static-build              # Generate static site to build/ directory
bin/parklife build            # Generate static site using Parkfile config
```

### Code Quality
```bash
bin/rubocop           # Lint Ruby code
bin/rubocop -a        # Auto-fix correctable issues
bin/brakeman          # Security scan
bin/importmap audit   # Security check for JavaScript dependencies
```

## Architecture

### Directory Structure
- `_posts/`: Blog post Markdown files
  - `ja/`: Japanese posts (organized by year)
  - `en/`: English posts
- `_uploads/blog/`: Blog post images
- `app/`: Rails application
  - `models/post.rb`: Blog post model (uses FrontMatterParser)
  - `controllers/`: Various controllers
  - `views/`: ERB templates

### Key Components

**Post Model** (`app/models/post.rb`)
- Loads blog posts from Markdown files
- Parses metadata with FrontMatterParser
- Converts to HTML using Kramdown (GFM)
- Determines language based on `ja/` directory presence

**Routing** (`config/routes.rb`)
- English: `/posts/year/month/slug` (default)
- Japanese: `/ja/blog/year/month/slug`
- Legacy URLs (`/blog/*`) redirect to Japanese version

**Parkfile Configuration**
- Static site generation settings
- `nested_index: true` maintains directory structure
- Generates posts, feeds, sitemap.xml

### Internationalization
- `ApplicationController#set_locale`: Determines language from URL path
- English is default, `/ja` prefix for Japanese
- Feeds: `/feed.xml` (English), `/ja/feed.xml` (Japanese)

## GitHub Actions

**CI** (`.github/workflows/ci.yml`)
- Security scanning (Brakeman, importmap audit)
- Rubocop linting
- RSpec test execution

**Deployment** (`.github/workflows/parklife.yml`)
- Auto-deploy on push to main branch
- Static site generation with Parklife
- Deploy to GitHub Pages
