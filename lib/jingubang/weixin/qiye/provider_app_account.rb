module Jingubang::Weixin::Qiye
  module ProviderAppAccount

    # Required fields:
    #   field :access_token, type: String
    #   field :expired_at, type: Time
    #   field :permanent_code, type: String
    #   def refreshed_access_token

    BASE_URL = 'https://qyapi.weixin.qq.com'

    def self.included(host_class)
      host_class.include Jingubang::HttpClient
      host_class.base_url BASE_URL
      host_class.extend ClassMethods
    end

    module ClassMethods

      def get_permanent_code auth_code
        path = "/cgi-bin/service/get_permanent_code?suite_access_token=#{refreshed_access_token}"
        fire_request path, {auth_code: auth_code}
      end

      def get_auth_info corpid, permanent_code
        path = "/cgi-bin/service/get_auth_info?suite_access_token=#{refreshed_access_token}"
        fire_request path, {auth_corpid: corpid, permanent_code: permanent_code}
      end

    end

  end
end
