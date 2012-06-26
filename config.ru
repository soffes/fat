require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra'
require './app'
run Sinatra::Application
