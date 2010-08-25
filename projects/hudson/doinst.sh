config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/hudson.conf.new
config etc/rc.d/rc.hudson.new

if ! grep -qw hudson /etc/group ; then
	groupadd -g 300 -r hudson
fi

if ! grep -qw hudson /etc/passwd ; then
	useradd -k /dev/null -g 300 -M -r -s /bin/bash -d /var/lib/hudson -g hudson hudson
fi

chown -R hudson.hudson /var/lib/hudson

