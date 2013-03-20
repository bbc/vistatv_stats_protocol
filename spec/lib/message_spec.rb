require_relative '../spec_helper'
require 'message'

describe Message do
  describe 'instantiation' do
    it "instantiates from a string" do
      message = Message.new('OK|command_name|{"bbc_one": "shows"}')
    
      message.status.should  eql 'OK'
      message.command.should eql 'command_name'
      message.data.should    eql ({"bbc_one" => "shows"})
    end
    
    it "instantiates from an array" do
      status  = 'ACK'
      command = 'array'
      data    = '{}'
      
      message = Message.new(status, command, data)
    
      message.status.should  eql 'ACK'
      message.command.should eql 'array'
      message.data.should    eql Hash.new
    end

    it "instantiates from a hash" do
      message = Message.new(:status => 'OK', :command => 'hash_test', :data => '{"hash":true}')
    
      message.status.should  eql 'OK'
      message.command.should eql 'hash_test'
      message.data.should    eql ({"hash" => true})
    end
  end
  
  describe '#data' do
    it "parses JSON" do
      message = Message.new(:data => '{"radio_one": "smashing"}')
      message.data.should eql ({"radio_one" => "smashing"})
    end
  end
  
  describe '#serialize' do
    it "encodes JSON" do
      message = Message.new(:status => 'OK', :command => 'music', :data => {"radio_three" => "classic"})
      message.serialize.should eql 'OK|music|{"radio_three":"classic"}'
    end
    
    it "fails unless well formed" do
      message = Message.new(:status => 'OK', :data => {"radio_three" => "classic"})
      expect { message.serialize }.to raise_exception Message::MalformedError
    end
  end
end
