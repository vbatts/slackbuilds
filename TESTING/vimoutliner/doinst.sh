runtimepath=$(vim --version | grep "fall-back for .VIM" | cut -d : -f 2 | tr -d \")
vim -c "helptags ${runtimepath}/vimfiles/doc" -c q
unset runtimepath
