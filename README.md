![](http://i.imgur.com/eyvne0z.jpg)

![](https://i.imgur.com/3Wg0I96.jpg)

Document related files reside in docs/

There is a templates directory where you store the markdown files.

Running the command without a path argument shows a picker to choose a template.

The shown files are ordered by modification date. Only the first 20 are shown.

Using "A" renders all files in the directory (not just the ones shown).

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

Alternatively use the nim compiler to compile from source.

### Options

```
--no-css
Don't add the style tag

--no-favicon
Don't add the favicon tag

--no-background
Don't add the background element

--no-footer
Don't add the footer element

--docs-path
Change the docs directory to use
For example --docs-path=/home/me/docs

--style-suffix
Used to add something at the end of the css file
For instance: --style-suffix=2 
will produce style2.css

--favicon-suffix
Used to add something at the end of the css file
For instance: --favicon-suffix=2 
will produce favicon2.png

--favicon-suffix
Used to add something at the end of the css file
For instance: --favicon-suffix=2 
will produce favicon2.png

--container-class
Adds a class to the container
For instance: --container-class=big
will produce class='big'

--background-class
Adds a class to the background
For instance: --background-class=sunset
will produce class='sunset'

--footer-class
Adds a class to the footer
For instance: --footer-class=notice
will produce class='notice'

--name
Set the output file to a custom name
For instance: --name=test
will save it as render/pages/test.html

--additional-css
List of extra css files to include
For instance: --additional-css="big red"
will include extra/css/big.css and
extra/css/red.css

--additional-js
List of extra js files to include
For instance: --additional-js="math video"
will include extra/js/math.js and
extra/js/video.js
```

### Styling

Some basic styling is provided by default.

But the css file and images are completely customizable.

### More

There is a run.sh script to run a debug version.

There is a build.sh script to build a release version.

There is a buildinstall.sh script to build and install.