module Jingubang
  class Setting

    def self.qiye
      @qiye_setting
    end

    # {
    #   suite_id: '',
    #   sign_token: '',
    #   encoding_aes_key: ''
    # }
    def self.qiye= settings
      @qiye_setting = settings
    end

  end
end
