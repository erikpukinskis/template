require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'
require 'sinatra-authentication'

use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET'] || 'This is a secret key that no one will guess~'

class Something
  include DataMapper::Resource
  property :id, Serial
  property :stuff, String
  property :dm_user_id, Integer
  belongs_to :dm_user
end

class DmUser
  has n, :somethings
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/test.db")
DataMapper.auto_upgrade!

get '/' do
  auto_login
  @somethings = current_user.somethings
  haml :index
end

post '/somethings' do
  current_user.somethings.create(params)
  redirect '/'
end

def name
  current_user.email.split("@")[0]
end

def registered?
  !!current_user.email
end

def auto_login
  unless logged_in?
    user = User.set({})
    user.save!
    session[:user] = user.id
  end
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
        - if registered?
          %li Welcome #{name}!
          %li
            %a{:href => '/logout'} Log out
        - else
          %li
            %a{:href => '/login'} Log in
          %li
            %a{:href => "/users/#{current_user.id}/edit"} Sign up
      #title Name goes here
    = yield

@@ index
- if logged_in?
  %form{:method => 'post', :action => '/somethings'}
    %input{:name => 'stuff'}
    %input{:type => 'submit', :value => 'save'}
  %ul
    - @somethings.each do |thing|
      %li= thing.stuff
- else
  %p Sign up to post stuff!
