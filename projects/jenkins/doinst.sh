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

config etc/jenkins.conf.new
config etc/rc.d/rc.jenkins.new

if ! grep -qw jenkins /etc/group ; then
	echo -ne "adding jenkins group : "
	echo "groupadd -g 300 -r jenkins"
	groupadd -g 300 -r jenkins
fi

if ! grep -qw jenkins /etc/passwd ; then
	echo -ne "adding jenkins user : "
	echo "useradd -k /dev/null -g 300 -M -r -s /bin/bash -d /var/lib/jenkins -g jenkins jenkins"
	useradd -m -k /dev/null -u 300 -g 300 -r -s /bin/bash -d /var/lib/jenkins -g jenkins jenkins
fi

echo -ne "changing ownership of jenkins's home : "
echo "chown -R jenkins.jenkins /var/lib/jenkins"
chown -R jenkins.jenkins /var/lib/jenkins

