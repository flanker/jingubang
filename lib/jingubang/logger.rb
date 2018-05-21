module Jingubang

  @@logger = ::Logger.new(STDOUT)

  def self.logger
    @@logger
  end

  def self.logger= value
    @@logger = value
  end

end
