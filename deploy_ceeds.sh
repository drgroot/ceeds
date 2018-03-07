#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# perform git updates
cd $DIR
git pull origin master
cd themes/detox && git pull origin master
rm -rf $DIR/public
rm -rf $DIR/content/post/

# copy posts over
/usr/bin/rclone copy google:documents/ceeds/ $DIR/content/post/

# generate the website to static HTML
# and deploy website 
cd $DIR && hugo --theme=detox
/usr/bin/firebase deploy
