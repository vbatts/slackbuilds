if [ -e /usr/share/slib/guile.init ] ; then
  ln -s /usr/share/slib /usr/share/guile/slib
  guile -c "(use-modules (ice-9 slib)) (require 'printf)"
fi
