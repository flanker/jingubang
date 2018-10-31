module Jingubang::Weixin::Qiye::ProviderAppAccount
  module URL

    def corp_oauth_path(redirect_uri)
      "https://qy.weixin.qq.com/cgi-bin/loginpage?suite_id=#{suite_id}&pre_auth_code=#{pre_auth_code}&redirect_uri=#{redirect_uri}"
    end

  end
end
