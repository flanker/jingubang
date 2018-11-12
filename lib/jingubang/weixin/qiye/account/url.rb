module Jingubang::Weixin::Qiye::Account
  module URL

    def user_oauth_path(redirect_uri, state: '')
      "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{corpid}&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_base&state=#{state}#wechat_redirect"
    end

  end
end
