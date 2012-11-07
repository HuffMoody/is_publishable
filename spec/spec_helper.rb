require 'rubygems'
require 'bundler/setup'
gem 'activerecord'
gem 'activesupport'
require 'active_record'
gem 'sqlite3'
require 'sqlite3'

require 'is_publishable'

RSpec.configure do |config|
  
end

Time.zone = "Eastern Time (US & Canada)"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :samples do |t|
      t.boolean :published
      t.datetime :published_at
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.drop_table t
  end
end

