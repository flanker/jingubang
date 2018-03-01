require 'rest_client'

module Jingubang::Weixin::Qiye
  class UrlHelper

    class << self

      def user_oauth_path(redirect_uri, corpid: nil, agentid: nil, state: '')
        "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{corpid}&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_base&agentid=#{agentid}&state=#{state}#wechat_redirect"
      end

      def third_party_user_oauth_path(redirect_uri, agentid: nil, state: '', user_type: 'member')
        "https://open.work.weixin.qq.com/wwopen/sso/3rd_qrConnect?appid=#{agentid}&redirect_uri=#{redirect_uri}&state=#{state}&usertype=#{user_type}"
      end

    end
  end
end
