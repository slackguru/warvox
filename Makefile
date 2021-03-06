all: test

test: install
	bin/verify_install.rb
	
install: bundler dtmf2num ruby-kissfft db
	cp -a src/dtmf2num/dtmf2num bin/

ruby-kissfft-install: ruby-kissfft
	cp -a src/ruby-kissfft/kissfft.so lib/

dtmf2num:
	make -C src/dtmf2num/
	
ruby-kissfft:
	( cd src/ruby-kissfft/; ruby extconf.rb )
	make -C src/ruby-kissfft/

db:
	@echo "Checking the database.."
	(cd web; RAILS_ENV=production bundle exec rake db:migrate )

bundler:
	@echo "Checking for RubyGems and the Bundler gem..."
	@ruby -rrubygems -e 'require "bundler"; puts "OK"'

	@echo "Validating that 'bundle' is in the path..."
	which bundle
	
	@echo "Installing missing gems as needed.."
	(cd web; bundle install)

clean:
	( cd src/ruby-kissfft/; ruby extconf.rb )
	make -C src/ruby-kissfft/ clean
	make -C src/dtmf2num/ clean
	rm -f lib/kissfft.so
