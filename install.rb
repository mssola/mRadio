#
# Author:: Copyright (C) 2011  Miquel Sabaté (mikisabate@gmail.com)
# License::
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
#


#!/usr/bin/env ruby


# This is a script that helps the user to install the script in the amarok's
# script directory. If you have a different amarok directory, please check
# the SCRIPT_PATH constant defined below.


require 'fileutils'


##
# Check if the given program exists on your system
#
# @param *String* program The name of the program.
#
# @return *Boolean* True if the program exists on your system,
# false otherwise.
def exists? program
  ENV['PATH'].split(File::PATH_SEPARATOR).any? do |directory|
    File.executable?(File.join(directory, program.to_s))
  end
end

# Check if exists coffee on your system
unless exists? 'coffee'
  puts %q{
    You need the coffee utility to run this script
    Install it with 'sudo npm install -g coffee-script'
  }; exit
end


HOME = `echo $HOME`.strip
SCRIPT_PATH = "#{HOME}/.kde4/share/apps/amarok/scripts"
MRADIO = SCRIPT_PATH + '/mRadio'


FileUtils.rm_rf MRADIO
FileUtils.cp_r Dir.pwd, SCRIPT_PATH
Dir.chdir MRADIO

`coffee -c main.coffee && rm main.coffee install.rb`
