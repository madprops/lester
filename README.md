![](http://i.imgur.com/oB5EyMw.jpg)

There is a templates directory where you store the markdown files.

Running the command without a path argument shows a picker to choose a template.

The shown files are ordered by modification date. Only the first 10 are shown.

The selected path is rendered into the docs directory as an html file.

There is an extra directory with a global css file that affects all docs.

A markdown file can have a title metadata line to indicate the page's title:

`title: This is the title of the document`

A path can be specified directly:

`lester /home/me/file.md`

### Options

```
--no-css
Don't add a style tag

--no-favicon
Don't add a favicon tag

--no-background
Don't include a background image