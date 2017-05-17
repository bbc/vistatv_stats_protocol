require_relative '../spec_helper'

describe VistaTV::StatsProtocol::Command do
  it "recognises overview" do
    command = VistaTV::StatsProtocol::Command.new("overview\n")

    expect(command.message).to eq('overview')
    expect(command.type).to eq(:overview)
  end

  it "recognises station command" do
    command = VistaTV::StatsProtocol::Command.new("station_bbc_radio_four\n")

    expect(command.message).to eq('station_bbc_radio_four')
    expect(command.type).to eq(:station)
    expect(command.param).to eq(:bbc_radio_four)
  end

  it "recognises stop command" do
    command = VistaTV::StatsProtocol::Command.new("stop_station_bbc_radio_five\n")
    expect(command.type).to eq(:stop)
    expect(command.param).to eq(:station_bbc_radio_five)
  end

  it "recognises discovery command" do
    command = VistaTV::StatsProtocol::Command.new("discovery\n")
    expect(command.type).to eq(:discovery)
  end

  it "invalidates other commands" do
    expect { VistaTV::StatsProtocol::Command.new("silly_command\n") }.to raise_exception VistaTV::StatsProtocol::Command::NotFoundError
  end

  it "invalidates incomplete commands" do
    expect { VistaTV::StatsProtocol::Command.new("stop_\n") }.to raise_exception VistaTV::StatsProtocol::Command::NotFoundError
  end

  it "accepts command in hash format" do
    command = VistaTV::StatsProtocol::Command.new(:type => 'station', :param => 'bbc_one')
    expect(command.message).to eq('station_bbc_one')
    expect(command.type).to eq(:station)
    expect(command.param).to eq(:bbc_one)
  end

  it "serializes" do
    command = VistaTV::StatsProtocol::Command.new('station', 'bbc_three')
    expect(command.serialize).to eq("station_bbc_three\n")

    command = VistaTV::StatsProtocol::Command.new('overview')
    expect(command.serialize).to eq("overview\n")
  end
end

