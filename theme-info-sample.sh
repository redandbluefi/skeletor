
#!/bin/bash
# A simple script for composer to load up themes

# Credentials
DESTDIR=htdocs/wp-content/themes
DESTSITE=theme-name

if [ -e $DESTDIR/$DESTSITE ]

then
    echo "Theme folder found, running npm tasks"
    cd $DESTDIR/$DESTSITE; npm install; npm run build
else
fi
