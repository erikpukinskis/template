require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'

class Something
  include DataMapper::Resource
  property :id, Serial
  property :stuff, String
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/test.db")
DataMapper.auto_upgrade!

get '/' do
  haml :index
end

__END__

@@ layout
!!! XML
!!!
%html
  %head
    %title hello!
    %link{:rel => 'stylesheet', :type => 'text/css', :href => '/base.css'}
  %body
    = yield

@@ index
hi
