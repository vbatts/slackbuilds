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
	echo -ne "adding hudson group : "
	echo "groupadd -g 300 -r hudson"
	groupadd -g 300 -r hudson
fi

if ! grep -qw hudson /etc/passwd ; then
	echo -ne "adding hudson user : "
	echo "useradd -k /dev/null -g 300 -M -r -s /bin/bash -d /var/lib/hudson -g hudson hudson"
	useradd -k /dev/null -g 300 -M -r -s /bin/bash -d /var/lib/hudson -g hudson hudson
fi

echo -ne "changing ownership of hudson's home : "
echo "chown -R hudson.hudson /var/lib/hudson"
chown -R hudson.hudson /var/lib/hudson

