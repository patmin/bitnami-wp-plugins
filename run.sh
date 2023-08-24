#!/bin/bash

sudo apt-get –y update
sudo apt-get install jq -y
sudo apt-get –y install unzip

mkdir ./tempdir-wpplugins
cd ./tempdir-wpplugins

plugins=("elementor" "all-in-one-wp-migration" "unlimited-elements-for-elementor")

for plugin in "${plugins[@]}"
do
        wget https://api.wordpress.org/plugins/info/1.0/"${plugin}".json
        value=($(jq -r '.download_link' ${plugin}.json))
        echo $value
done

FILES="./*"

for f in $FILES
do
  unzip $f -d /opt/bitnami/wordpress/wp-content/plugins
done

sudo /opt/bitnami/bncert-tool