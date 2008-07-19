zcat $CWD/kdebase-3.5.9.lmsensors.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
