require_relative '../spec_helper'

describe VistaTV::StatsProtocol::Command do
  it "recognises overview" do
    command = VistaTV::StatsProtocol::Command.new("overview\n")

    command.message.should eql 'overview'
    command.type.should eql :overview
  end

  it "recognises station command" do
    command = VistaTV::StatsProtocol::Command.new("station_bbc_radio_four\n")

    command.message.should eql 'station_bbc_radio_four'
    command.type.should  eql  :station
    command.param.should eql  :bbc_radio_four
  end

  it "recognises stop command" do
    command = VistaTV::StatsProtocol::Command.new("stop_station_bbc_radio_five\n")
    command.type.should  eql  :stop
    command.param.should eql  :station_bbc_radio_five
  end

  it "recognises discovery command" do
    command = VistaTV::StatsProtocol::Command.new("discovery\n")
    command.type.should  eql  :discovery
  end

  it "invalidates other commands" do
    expect { VistaTV::StatsProtocol::Command.new("silly_command\n") }.to raise_exception VistaTV::StatsProtocol::Command::NotFoundError
  end

  it "invalidates incomplete commands" do
    expect { VistaTV::StatsProtocol::Command.new("stop_\n") }.to raise_exception VistaTV::StatsProtocol::Command::NotFoundError
  end

  it "accepts command in hash format" do
    command = VistaTV::StatsProtocol::Command.new(:type => 'station', :param => 'bbc_one')
    command.message.should eql 'station_bbc_one'
    command.type.should eql :station
    command.param.should eql :bbc_one
  end

  it "serializes" do
    command = VistaTV::StatsProtocol::Command.new('station', 'bbc_three')
    command.serialize.should eql "station_bbc_three\n"

    command = VistaTV::StatsProtocol::Command.new('overview')
    command.serialize.should eql "overview\n"
  end
end

