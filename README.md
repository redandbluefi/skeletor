# :warning: Deprecated
## skeletor hasn't been updated for a long time and basically it's just a clone of Seravo's WordPress base.
## Prefer to use Seravo's WordPress base instead of this. Even better, use 'theme-skeletor' with Docker, if you can.

![redandblue.fi](https://media.giphy.com/media/5XPb0FvIqylqg/giphy.gif)

# redandblue skeletor

Duplicated from seravo/wordpress, More instructions coming up ..
#### Seravo wordpress docs / information
- Detailed information about the box & installation guides
- https://github.com/Seravo/wordpress
- https://seravo.com/docs/

#### Skeletor installation
- https://seravo.com/docs/development/how-to-install/


- ``cp config-sample.yml config.yml``
- Add correct project name to config file
- ``cp theme-info-sample.sh to theme-info.sh``
- Add the correct project filenames to variables
- ``chmod 0775 theme-info.sh to make it executable``
- ``cp vagrant-up-customizer-sample.sh to vagrant-up-customizer.sh``
- Change DESTSITE to correct theme / git repo

#### Example from vagrant-up-customizer.sh bash script that is executed on vagrant up / composer update
- When running for the first time it will clone the DESTSITE repository to the DESTDIR location.
- Make sure that DESTSITE matches the name of the Github repository

```
#!/bin/bash
# A simple script for composer to load up themes

# Credentials
DESTDIR=htdocs/wp-content/themes
DESTSITE=your-theme-name
GITURL=https://github.com/redandbluefi

if [ -e $DESTDIR/$DESTSITE ]

then
    echo "Theme folder found, running npm tasks"
    cd $DESTDIR/$DESTSITE; npm install; npm run build
else
    echo "Theme folder NOT found, creating a new one.."
    cd $DESTDIR;
    git clone $GITURL/$DESTSITE;
    cd $DESTSITE; npm install; npm run build
fi


```  

### Credentials for vagrant

WordPress:
```
user:     vagrant
password: vagrant
```

MariaDB (MySQL):
```
user:     root
password: root
```


## Configuration

### config.yml
Change `name` in config.yml to change your site name. This is used in quite some places in development environment.

Add `production => domain` and `production => ssh_port` to sync with your production instance.

Add new domains under `development => domains` before first vagrant up to have extra domains.

See `config-sample.yml` for more


## WordPress plugins

The composer.json contains some plugins and themes that are likely to be useful for pretty much every installation. For particular use cases see our list of recommended plugins at http://wp-palvelu.fi/lisaosat/

Note that all plugins are installed, but not active by default. To activate them, run `vagrant ssh -c "wp plugin activate --all"`.
