#!/usr/bin/env ruby
###################

#
# Load the library path
# 
base = __FILE__
while File.symlink?(base)
	base = File.expand_path(File.readlink(base), File.dirname(base))
end
$:.unshift(File.join(File.expand_path(File.dirname(base)), '..', 'lib'))
require 'warvox'

#
# Verify that WarVOX has been installed properly
#

puts("**********************************************************************")
puts("*                                                                    *")
puts("*                  WarVOX Installation Verifier                      *")
puts("*                                                                    *")
puts("**********************************************************************")
puts(" ")


begin
	require 'rubygems'
	puts "[*] RubyGems have been installed"
rescue ::LoadError
	puts "[*] ERROR: The RubyGems package has not been installed:"
	puts "    $ sudo apt-get install rubygems"
	exit
end

begin
	require 'bundler'
	puts "[*] The Bundler gem has been installed"
rescue ::LoadError
	puts "[*] ERROR: The Bundler gem has not been installed:"
	puts "    $ sudo gem install bundler"	
	exit
end

begin 
	require 'kissfft'
	puts "[*] The KissFFT module appears to be available"
rescue ::LoadError
	puts "[*] ERROR: The KissFFT module has not been installed"
	exit
end

if(not WarVOX::Config.tool_path('gnuplot'))
	puts "[*] ERROR: The 'gnuplot' binary could not be installed"
	exit
end
puts "[*] The GNUPlot binary appears to be available"

if(not WarVOX::Config.tool_path('lame'))
	puts "[*] ERROR: The 'lame' binary could not be installed"
	exit
end
puts "[*] The LAME binary appears to be available"


if(not WarVOX::Config.tool_path('dtmf2num'))
	puts "[*] ERROR: The 'dtmf2num' binary could not be installed"
	exit
end
puts "[*] The DTMF2NUM binary appears to be available"


puts " "
puts "[*] Congratulations! You are almost ready to run WarVOX"
puts " "
puts "[*] Configuring the PostgreSQL database server:"
puts "[*] 1. Install postgresql:"
puts "[*]    $ sudo apt-get install postgresql-8.4"
puts "[*]"
puts "[*] 2. Install postgresql community contributed modules:"
puts "[*]    $ sudo apt-get install postgresql-8.4-contrib"
puts "[*]"
puts "[*] 3. Load contributed integer routines into template1:"
puts "[*]    $ sudo su - postgres"
puts "[*]    $ psql template1"
puts "[*]    psql> \\i /usr/share/postgresql/8.4/contrib/_int.sql"
puts "[*]    psql> exit"
puts "[*]"
puts "[*] 4. Configure a user account, password, and database for WarVOX:"
puts "[*]    $ sudo su - postgres"
puts "[*]    $ createuser warvox"
puts "[*]    $ createdb warvox -O warvox"
puts "[*]    $ psql"
puts "[*]    psql> alter user warvox with password 'randompass';"
puts "[*]    psql> exit"
puts "[*]"
puts "[*] 5. Modify web/config/database.yml to match this password"
puts "[*]"
puts "[*] 6. Modify etc/warvox.conf and set a UI password"
puts "[*]"
puts "[*] 7. Start WarVOX with bin/warvox.rb"
puts "[*]"
puts "[*] 8. Login to http://127.0.0.1:7777/"
puts "[*]"
