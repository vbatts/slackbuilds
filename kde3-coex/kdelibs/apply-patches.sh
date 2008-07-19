zcat $CWD/kdelibs-utempter.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat $CWD/kdelibs-kate-cursor-fix.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat $CWD/post-kde-3.5.5-kinit.diff.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1
