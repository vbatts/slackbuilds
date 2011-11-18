from distutils.core import setup
import sys

setup (name              = "pymake",
       version           = "default",
       description       = "pymake - python implementation of GNU make ",
       maintainer        = "Benjamin Smedberg",
       maintainer_email  = "",
       license           = "MIT",
       long_description  = "pymake - python implementation of GNU make ",
       url               = "http://benjamin.smedbergs.us/pymake/",
       platforms         = ['Any'],
       packages          = ['pymake'],
       py_modules        = [],
       scripts           = ['make.py'],
       data_files        = [('doc/pymake-default', ['LICENSE','README']) ],
       )
