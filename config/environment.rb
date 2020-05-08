
require 'bundler'
require 'net/http'
require 'open-uri'
require 'json'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
require 'faker'
require 'ascii'
require 'artii'
require 'colorize'
require 'colorized_string'

ActiveRecord::Base.logger = nil
