EmbedJournal Jekyll Template
============================

# Jekyll

Have a look at [installation guide](INSTALL.md) for setting up the build
environment. Explore our build assitant **fervour** with `./fervour --help`.

### Notes:

* Collection names do not seem to support HYPHEN in them, use UNDER_SCORE
  instead.
* collection names cannot be same as global variables (site.VARIABLE) as
  collections get get into into global scope (site.COLLECTION) as well.

### Dependency Chain

**CSS:**:
``` text
bootstrap.css
bootstrap-theme.css
```

**JS:**
``` text
jquery.js
bootstrap.js
bootstrap-theme.js
```

### Issues:

* pagination doesn't work in IE 11.
* image size not restricted in IE 11.
