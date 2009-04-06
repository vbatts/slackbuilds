#!/bin/sh
# $Id$

#set -x

JAVA=$(which java)
PIDFILE="/var/run/hudson.pid"
HUDSON="/usr/lib/hudson/hudson.war"
HUDSON_HTTP_PORT="8080"
HUDSON_LOG_FILE="/var/log/hudson.log"
HUDSON_WEBAPPSDIR="/var/lib/hudson/apps/"
HUDSON_WEBROOT="/var/lib/hudson/webroot/"

if [ "$UID" -ne 0 ] ; then
  echo Please be root
  exit 1
fi

if [ -e $PIDFILE ] ; then
  rm $PIDFILE
fi

if [ -f /etc/hudson.conf ] ; then
  . /etc/hudson.conf
fi

if [ "$HUDSON_IS_DAEMON" = "true" ] ; then
  HUDSON_DAEMON_ARG="--daemon"
fi

if [ "$HUDSON_HTTP_PORT" != "" ] ; then
  HUDSON_HTTP_PORT_ARG="--httpPort=$HUDSON_HTTP_PORT"
fi

if [ "$HUDSON_HTTP_LISTENING_ADDRESS" != "" ] ; then
  HUDSON_HTTP_LISTENING_ADDRESS_ARG="--httpListenAddress=$HUDSON_HTTP_LISTENING_ADDRESS"
fi

if [ "$HUDSON_HTTPS_PORT" != "" ] ; then
  HUDSON_HTTPS_PORT_ARG="--httpsPort=$HUDSON_HTTPS_PORT"
fi

if [ "$HUDSON_HTTPS_LISTENING_ADDRESS" != "" ] ; then
  HUDSON_HTTPS_LISTENING_ADDRESS_ARG="--httpsListenAddress=$HUDSON_HTTPS_LISTENING_ADDRESS"
fi

if [ "$HUDSON_HTTPS_KEYSTORE" != "" ] ; then
  HUDSON_HTTPS_KEYSTORE_ARG="--httpsKeyStore=$HUDSON_HTTPS_KEYSTORE"
fi

if [ "$HUDSON_HTTPS_KEYSTORE_PASSWORD" != "" ] ; then
  HUDSON_HTTPS_KEYSTORE_PASSWORD_ARG="--httpsKeyStorePassword=$HUDSON_HTTPS_KEYSTORE_PASSWORD"
fi

if [ "$HUDSON_HTTPS_KEY_MANAGER" != "" ] ; then
  HUDSON_HTTPS_KEY_MANAGER_ARG="--httpsKeyManagerType=$HUDSON_HTTPS_KEY_MANAGER"
fi

if [ "$HUDSON_LOG_FILE" != "" ] ; then
  HUDSON_LOG_FILE_ARG="--logfile=$HUDSON_LOG_FILE"
fi

if [ "$HUDSON_WEBAPPSDIR" != "" ] ; then
  HUDSON_WEBAPPSDIR_ARG="--webapssDir=$HUDSON_WEBAPPSDIR"
fi

if [ "$HUDSON_WEBROOT" != "" ] ; then
  HUDSON_WEBROOT_ARG="--webroot=$HUDSON_WEBROOT"
fi

exec $JAVA -jar $HUDSON \
  $HUDSON_DAEMON_ARG \
  $HUDSON_HTTP_PORT_ARG \
  $HUDSON_HTTP_LISTENING_ADDRESS_ARG \
  $HUDSON_HTTPS_PORT_ARG \
  $HUDSON_HTTPS_LISTENING_ADDRESS_ARG \
  $HUDSON_HTTPS_KEYSTORE_ARG \
  $HUDSON_HTTPS_KEYSTORE_PASSWORD_ARG \
  $HUDSON_HTTPS_KEY_MANAGER_ARG \
  $HUDSON_LOG_FILE_ARG \
  $HUDSON_WEBAPPSDIR_ARG \
  $HUDSON_WEBROOT_ARG &

ps -ef | grep "/usr/lib/hudson/hudson.war" | awk '{ print $2 }' > $PIDFILE

