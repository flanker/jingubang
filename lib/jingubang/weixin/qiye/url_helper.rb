require 'rest_client'

module Jingubang::Weixin::Qiye
  class UrlHelper

    class << self

      def user_oauth_path(redirect_uri, corpid: nil, agentid: nil, state: '')
        "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{corpid}&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_base&agentid=#{agentid}&state=#{state}#wechat_redirect"
      end

    end
  end
end
