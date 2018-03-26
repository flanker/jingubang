module Jingubang

  @@logger = ::Logger.new(STDOUT)

  def self.logger
    @@logger
  end

end
