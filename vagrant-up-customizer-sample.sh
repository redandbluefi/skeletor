#!/bin/bash
# A simple script for composer to setup custom credentials

# Finally, edit the installation, if necessary
sudo -u vagrant -i -- wp user get "redandblue.admin" > /dev/null &> /dev/null

if [ "$?" == "0" ]; then
  echo "Skipping setup, existing installation."
else
  PASSWORD=$(openssl rand -base64 32 | head -c32)

  sudo -u vagrant -i -- wp user create "redandblue.admin" "dev@redandblue.fi" --role="administrator" \
    --display_name="Administrator" --user_pass="$PASSWORD"
  sudo -u vagrant -i -- wp user delete 1 --yes

  # Switch theme to ours (assuming there's only 1 theme)
  sudo -u vagrant -i -- wp theme activate $(sudo -u vagrant -i -- wp theme list --field=name --format=csv | head -n 1)

  # Turn all plugins on (delete those that you won't use!)
  sudo -u vagrant -i -- wp plugin list --field=name --format=csv | xargs sudo -u vagrant -i -- wp plugin activate --quiet

  # Create demopage
  sudo -u vagrant -i -- wp post create --post_type=page --post_title='Element demo' --page_template='element-demo.php' --post_status=publish

  echo "If this looks like it failed, log into the machine (vagrant ssh) and run the script with '/data/wordpress/vagrant-up-customizer.sh'"
  echo "It probably worked just fine even if the output has errors."
  echo "Your username is redandblue.admin"
  echo "Your password is $PASSWORD"
  echo "Save these credentials to LastPass now."
fi
