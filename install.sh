sudo cp bin/lester /bin/lester

echo "Binary placed in /bin/lester"

if [[ -d ~/.config/lester ]]
then
    echo "Data directory exists already."
else
    mkdir ~/.config/lester
    cp -R docs ~/.config/lester
    echo "Data files placed in ~/.config/lester"
fi

echo "Done."