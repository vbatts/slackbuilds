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

userid=300
groupid=300

if ! grep -qw jenkins etc/group ; then
	cmd="groupadd -g ${groupid} -r jenkins"
	echo "INFO: adding jenkins group : ${cmd}"
	${cmd}
fi

if ! grep -qw jenkins etc/passwd ; then
	cmd="useradd -k /dev/null -g ${userid} -M -r -s bin/bash -d var/lib/jenkins -g jenkins jenkins"
	echo "INFO: adding jenkins user : ${cmd}"
	${cmd}
fi

cmd="chown -R jenkins.jenkins var/lib/jenkins"
echo "INFO: changing ownership of jenkins's home : ${cmd}"
${cmd}

cmd="chown -R jenkins.jenkins var/log/jenkins_console.log"
echo "INFO: setting ownership of jenkins's console log : ${cmd}"
touch var/log/jenkins_console.log
${cmd}

cmd="chown -R jenkins.jenkins var/log/jenkins.log"
echo "INFO: setting ownership of jenkins's log : ${cmd}"
touch var/log/jenkins.log
${cmd}

cmd="chown -R jenkins.jenkins var/run/jenkins.pid"
echo "INFO: setting ownership of jenkins's pid : ${cmd}"
touch var/run/jenkins.pid
${cmd}

