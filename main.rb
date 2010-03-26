require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'
require 'sinatra-authentication'

use Rack::Session::Cookie, :secret => 'yarr, how many times can a secret be reused? They will never guess the the ~ilde'

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

def name
  current_user.email.split("@")[0]
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
    #top_bar
      %ul#account_links
        - if logged_in?
          %li Welcome #{name}!
          %li
            %a{:href => '/logout'} Log out
        - else
          %li
            %a{:href => '/login'} Log in
          %li
            %a{:href => '/signup'} Sign up
      #title Name goes here
    = yield

@@ index
hi
