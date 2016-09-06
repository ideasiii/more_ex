#!/bin/sh

cd /data/opt/tomcat/webapps/IdeasDeveloperConsole/;git pull >> /data/opt/tomcat/webapps/logs/git.log
cp /data/opt/tomcat/webapps/IdeasDeveloperConsole/utility/libs/*.* /data/opt/tomcat/lib
