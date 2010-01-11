#!/bin/bash
#
# this script is freely available
# and comes with NO WARRANTY.
#
# Vincent Batts, vbatts@hashbangbash.com, 2008-09


# Global Variables
ARGS=$@
OWD=$(pwd)
OUTPUT=${OUTPUT:-/tmp}
PKGTYPE=${PKGTYPE:-txz}

# Functions
convertRpm() {
  # Instance vairables
  RPM=$1
  PRGNAM=$(rpm -qp --qf %{NAME} $RPM )
  ARCH=$(rpm -qp --qf %{ARCH} $RPM )
  VERSION=$(rpm -qp --qf %{VERSION} $RPM )
  BUILD=$(rpm -qp --qf %{RELEASE} $RPM )
  WRKDIR="/tmp/$PRGNAM-rpm.$RANDOM"

  mkdir -p -m 0755 $WRKDIR/install || exit 1
  cd $WRKDIR || exit 1
  
  ## Create our slack-desc
  rpm -qp --qf %{SUMMARY} $OWD/$RPM | sed -l 70 -r "s/^(.*)/$PRGNAM: $PRGNAM - \1\n/" > $WRKDIR/install/slack-desc || exit 1
  rpm -qp --qf %{DESCRIPTION} $OWD/$RPM | sed -l 70 -r "s/^/$PRGNAM: /" >> $WRKDIR/install/slack-desc || exit 1
  
  ## i'm only using the {pre,post}install scripts, no {pre,post}uninstall scripts.
  echo '#!/bin/sh' > $WRKDIR/install/doinst.sh || exit 1
  if [ "$(rpm -qp --qf %{PREIN} $OWD/$RPM )" != '(none)' ] ; then
    rpm -qp --qf %{PREIN} $OWD/$RPM >> $WRKDIR/install/doinst.sh || exit 1
  fi
  echo "" >> $WRKDIR/install/doinst.sh || exit 1
  if [ "$(rpm -qp --qf %{POSTIN} $OWD/$RPM )" != '(none)' ] ; then
    rpm -qp --qf %{POSTIN} $OWD/$RPM >> $WRKDIR/install/doinst.sh || exit 1
  fi
  echo "" >> $WRKDIR/install/doinst.sh || exit 1
  
  ## extract the rpm
  rpm2cpio $OWD/$RPM | cpio -idvm  || exit 1
  find . -type d -perm 700 -exec chmod 755 {} \; || exit 1
  
  ## make a slack package
  /sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-${BUILD}.${PKGTYPE} || exit 1
}

# Main
if [ $UID != 0 ] ; then 
    echo "Please run as root"
    exit 1
fi

for arg in $ARGS ; do
  if [ -f $arg ] ; then
    convertRpm $arg
    cd ${CWD}
  else
    echo ERROR : $arg not readable
  fi
done
