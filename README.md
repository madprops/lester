![](http://i.imgur.com/jcNF8si.jpg)

![](http://i.imgur.com/J8bcDpG.jpg)

Document related files reside in docs/

There is a templates directory where you store the markdown files.

Running the command without a path argument shows a picker to choose a template.

The shown files are ordered by modification date. Only the first 10 are shown.

The selected path is rendered into the docs/render/pages directory as an html file.

There is an extra directory in render with global files that affect all pages.

A markdown file can have a title metadata line to indicate the page's title:

`title: This is the title of the document`

A path can be specified directly:

`lester /home/me/file.md`

Using just the name will attempt to look in the templates directory:

`lester mytemplate.md`

### Installation

Run `install.sh`

This will place the binary from bin/ into /bin/lester

Then it will create a ~/.config/lester directory.

Inside this directory is where your templates and pages exist.

### Options

```
--no-css
Don't add a style tag

--no-favicon
Don't add a favicon tag

--no-background
Don't include a background image

--docs-path
Change the docs directory to use
For example --docs-path=/home/me/docs
```

### More

There is a run.sh script to run a debug version.

There is a build.sh script to build a release version.

There is a buildinstall.sh script to build and install.