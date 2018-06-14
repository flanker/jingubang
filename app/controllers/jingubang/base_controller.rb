module Jingubang
  class BaseController < ActionController::Base

    private

    def log message
      Jingubang.logger.info message
    end

  end
end
