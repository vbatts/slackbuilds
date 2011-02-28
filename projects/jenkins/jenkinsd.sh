#!/bin/sh
# $Id$

#set -x

JAVA=$(which java)
JENKINS="/opt/jenkins/jenkins.war"
JENKINS_USER="jenkins"
JENKINS_HTTP_PORT="8080"
JENKINS_LOG_FILE="/var/log/jenkins.log"
JENKINS_WEBAPPSDIR="/var/lib/jenkins/apps/"
JENKINS_WEBROOT="/var/lib/jenkins/webroot/"
OPT_ARGS=""
export JENKINS_HOME="/var/lib/jenkins"

## removing this while experimenting running as a limited user
#if [ "$UID" -ne 0 ] ; then
#  echo Please be root
#  exit 1
#fi

PREV_PID=$( pgrep -f "/opt/jenkins/jenkins.war" )
if [ ! "$PREV_PID" = "" ] ; then
  echo $PREV_PID still running
  exit 1
fi

if [ -f /etc/jenkins.conf ] ; then
  . /etc/jenkins.conf
fi

if [ "$JENKINS_IS_DAEMON" = "true" ] ; then
  JENKINS_DAEMON_ARG="--daemon"
fi

if [ "$JENKINS_PREFIX" != "" ] ; then
  JENKINS_PREFIX_ARG="--prefix=$JENKINS_PREFIX"
fi

if [ "$JENKINS_HTTP_PORT" != "" ] ; then
  JENKINS_HTTP_PORT_ARG="--httpPort=$JENKINS_HTTP_PORT"
fi

if [ "$JENKINS_HTTP_LISTENING_ADDRESS" != "" ] ; then
  JENKINS_HTTP_LISTENING_ADDRESS_ARG="--httpListenAddress=$JENKINS_HTTP_LISTENING_ADDRESS"
fi

if [ "$JENKINS_HTTPS_PORT" != "" ] ; then
  JENKINS_HTTPS_PORT_ARG="--httpsPort=$JENKINS_HTTPS_PORT"
fi

if [ "$JENKINS_HTTPS_LISTENING_ADDRESS" != "" ] ; then
  JENKINS_HTTPS_LISTENING_ADDRESS_ARG="--httpsListenAddress=$JENKINS_HTTPS_LISTENING_ADDRESS"
fi

if [ "$JENKINS_HTTPS_KEYSTORE" != "" ] ; then
  JENKINS_HTTPS_KEYSTORE_ARG="--httpsKeyStore=$JENKINS_HTTPS_KEYSTORE"
fi

if [ "$JENKINS_HTTPS_KEYSTORE_PASSWORD" != "" ] ; then
  JENKINS_HTTPS_KEYSTORE_PASSWORD_ARG="--httpsKeyStorePassword=$JENKINS_HTTPS_KEYSTORE_PASSWORD"
fi

if [ "$JENKINS_HTTPS_KEY_MANAGER" != "" ] ; then
  JENKINS_HTTPS_KEY_MANAGER_ARG="--httpsKeyManagerType=$JENKINS_HTTPS_KEY_MANAGER"
fi

if [ "$JENKINS_LOG_FILE" != "" ] ; then
  JENKINS_LOG_FILE_ARG="--logfile=$JENKINS_LOG_FILE"
fi

if [ "$JENKINS_WEBAPPSDIR" != "" ] ; then
  JENKINS_WEBAPPSDIR_ARG="--webapssDir=$JENKINS_WEBAPPSDIR"
fi

if [ "$JENKINS_WEBROOT" != "" ] ; then
  JENKINS_WEBROOT_ARG="--webroot=$JENKINS_WEBROOT"
fi

su - $JENKINS_USER -c "$JAVA -jar $JENKINS \
  $JENKINS_DAEMON_ARG \
  $JENKINS_HTTP_PORT_ARG \
  $JENKINS_HTTP_LISTENING_ADDRESS_ARG \
  $JENKINS_HTTPS_PORT_ARG \
  $JENKINS_PREFIX_ARG \
  $JENKINS_HTTPS_LISTENING_ADDRESS_ARG \
  $JENKINS_HTTPS_KEYSTORE_ARG \
  $JENKINS_HTTPS_KEYSTORE_PASSWORD_ARG \
  $JENKINS_HTTPS_KEY_MANAGER_ARG \
  $JENKINS_LOG_FILE_ARG \
  $JENKINS_WEBAPPSDIR_ARG \
  $OPT_ARGS \
  $JENKINS_WEBROOT_ARG "

