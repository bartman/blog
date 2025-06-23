+++
title = "blogging reborn"
date = "2025-06-03T11:27:57-04:00"
#dateFormat = "2006-01-02" # This value can be configured for per-post date formatting
author = "bartman"
authorTwitter = "barttrojanowski" #do not include @
cover = ""
tags = ["hugo", "meta"]
keywords = ["hugo", "meta"]
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

## again

This seems to happen often.  I go through a consistent burst of blogging, then I get
distracted by work, and stop.

Well here is another attempt at blogging.  This time with hugo.

<!--more-->

So far I followed the [quickstart](https://gohugo.io/getting-started/quick-start/)
and picked this fancy [terminal](https://github.com/panr/hugo-theme-terminal) theme.

I'm here because I've been converting my dev system to NixOS, and I'm learning a lot
of new things.  Might as well put them to paper.

## configuration

I've decided to put my blog in `content/blog` directory, and to use the terminal theme.

```toml
baseURL = 'http://www.jukie.net/~bart/'
languageCode = 'en-us'
title = "bartman's blog"
theme = 'hugo-theme-re-terminal'

[markup.goldmark.renderer]
  unsafe = true

[params]
  contentTypeName = "blog"
  themeColor = "orange"
  showMenuItems = 10
  showLanguageSelector = false
  enableGitInfo = true           # use git for last update
  autoCover = true
  fullWidthTheme = false
  centerTheme = true
  readingTime = true
```

## archetypes

The `archetype` is a mechanism to template new content.

Running `hugo new content blog/something-something` will create
`content/blog/something-something/` directory with the contents
of `archetype/blog/` directory, with some substitutions applied.
In `archetype/blog/index.md` I have a standard "front-matter"...

```md
+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = '{{ .Date }}'

categories = ["blog"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["", ""]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = true
hideComments = false

draft = true
+++

## title

<!--more-->
```

