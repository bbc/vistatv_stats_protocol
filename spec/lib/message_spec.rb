require_relative '../spec_helper'

describe VistaTV::StatsProtocol::Message do
  describe 'instantiation' do
    it "instantiates from a string" do
      message = VistaTV::StatsProtocol::Message.new('OK|command_name|{"bbc_one": "shows"}')

      expect(message.status).to eq('OK')
      expect(message.command).to eq('command_name')
      expect(message.data).to eq({"bbc_one" => "shows"})
    end

    it "instantiates from an array" do
      status  = 'ACK'
      command = 'array'
      data    = '{}'

      message = VistaTV::StatsProtocol::Message.new(status, command, data)

      expect(message.status).to eq('ACK')
      expect(message.command).to eq('array')
      expect(message.data).to eq({})
    end

    it "instantiates from a hash" do
      message = VistaTV::StatsProtocol::Message.new(:status => 'OK', :command => 'hash_test', :data => '{"hash":true}')

      expect(message.status).to eq('OK')
      expect(message.command).to eq('hash_test')
      expect(message.data).to eq({"hash" => true})
    end
  end

  describe '#data' do
    it "parses JSON" do
      message = VistaTV::StatsProtocol::Message.new(:data => '{"radio_one": "smashing"}')
      expect(message.data).to eq({"radio_one" => "smashing"})
    end
  end

  describe '#serialize' do
    it "encodes JSON" do
      message = VistaTV::StatsProtocol::Message.new(:status => 'OK', :command => 'music', :data => {"radio_three" => "classic"})
      expect(message.serialize).to eq('OK|music|{"radio_three":"classic"}')
    end

    it "fails unless well formed" do
      message = VistaTV::StatsProtocol::Message.new(:status => 'OK', :data => {"radio_three" => "classic"})
      expect { message.serialize }.to raise_exception VistaTV::StatsProtocol::Message::MalformedError
    end
  end
end
