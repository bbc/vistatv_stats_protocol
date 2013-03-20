require 'rubygems'
require 'bundler/setup'

Bundler.require :test

require 'webmock/rspec'

WebMock.disable_net_connect!

# add lib to current path
$: << File.join(File.dirname(__FILE__), '..', 'lib')
