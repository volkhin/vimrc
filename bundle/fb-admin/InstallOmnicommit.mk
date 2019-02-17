all:
	test -d $$HOME/admin || { echo "Please check /svnroot/admin out as ~/admin" ; exit 1 ; }
	mkdir -p $$HOME/.vim/syntax
	mkdir -p $$HOME/.omnicommit
	ln -sf /mnt/vol/engshare/tools/cortana/people.dat     $$HOME/.omnicommit
	ln -sf /mnt/vol/engshare/tools/cortana/tags.dat       $$HOME/.omnicommit
	egrep -q "omnicommit" $$HOME/.vimrc || \
		printf '\n%s\n%s\n' >> ~/.vimrc \
      '"let g:omnicommit_turbo = 1' \
      'source ~/admin/scripts/vim/omnicommit.vim'
	@echo
	@echo 'Your vimrc has been modified.'
	@echo 'Uncomment the turbo line for turbo mode.'
	@echo 'Please add the following line to your personal crontab.'
	@echo '*/5 * * * * /usr/local/bin/php /var/www/scripts/traccamp/vim_typeahead_personal.php tasks > $$HOME/.omnicommit/tasks.dat 2>/dev/null'
