# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'capistrano/rbenv'
set :rbenv_type, :user
set :rbenv_ruby, '2.4.2'

require 'capistrano/rails'
require 'capistrano/puma'
install_plugin Capistrano::Puma
# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or


#   https://github.com/capistrano/bundler

#
# require "capistrano/rvm"
# require "capistrano/rbenv"
# require "capistrano/chruby"
 #require "capistrano/bundler"
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
require 'capistrano/setup'
require 'capistrano/nginx'
require 'capistrano/puma/nginx'
require 'capistrano/rails/db'
require 'capistrano/rails/console'
require 'capistrano/upload-config'
require 'sshkit/sudo'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
