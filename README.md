![](http://i.imgur.com/dRKX2Dm.jpg)

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

### Options

```
--no-css
Don't add a style tag

--no-favicon
Don't add a favicon tag

--no-background
Don't include a background image

### More

There is a run.sh script to run a debug version.

There is a build.sh script to build a release version.