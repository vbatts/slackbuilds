zcat $CWD/kdegraphics.fontpool.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
