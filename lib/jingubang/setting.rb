module Jingubang
  class Setting

    def self.qiye
      @qiye_setting ||= YAML.load_file('config/jingubang.yml').with_indifferent_access[:weixin_qiye_account]
    end

  end
end
