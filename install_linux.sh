sudo cp bin/lester-release-linux /bin/lester

echo "Binary placed in /bin/lester"

if [[ -d ~/.config/lester ]]
then
    :
else
    mkdir ~/.config/lester
    cp -R docs ~/.config/lester
    echo "Data files placed in ~/.config/lester"
fi

mkdir -p ~/.config/lester/docs
mkdir -p ~/.config/lester/docs/templates
mkdir -p ~/.config/lester/docs/render
mkdir -p ~/.config/lester/docs/render/pages
mkdir -p ~/.config/lester/docs/render/extra
mkdir -p ~/.config/lester/docs/render/extra/css
mkdir -p ~/.config/lester/docs/render/extra/js
mkdir -p ~/.config/lester/docs/render/extra/img

echo "Done."