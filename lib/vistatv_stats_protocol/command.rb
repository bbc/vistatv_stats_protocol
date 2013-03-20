class Command
  class NotFoundError < Exception; end
  attr_reader :message, :type, :param
  
  def initialize(message)
    @message = message.chomp
    @type, @param = parse
  end
  
  private
  def parse
    case message.downcase
    when 'overview'
      [:overview, nil]
    when /^station_([\w\d_]+)$/
      [:station, $1.to_sym]
    when /^stop_([\w\d_]+)$/
      [:stop, $1.to_sym]
    else
      raise NotFoundError, "#{message} not understood"
    end
  end
end
