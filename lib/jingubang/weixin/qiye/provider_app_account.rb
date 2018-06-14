require 'jingubang/weixin/qiye/provider_app_account/api'

module Jingubang::Weixin::Qiye
  module ProviderAppAccount

    # Required fields:
    #   reader only:
    #     * corpid
    #     * suite_id
    #     * suite_secret
    #     * encoding_aes_key
    #     * sign_token
    #     * provider_encoding_aes_key
    #     * provider_sign_token
    #     * custom_registration_id
    #     * test_mode
    #   reader and writer:
    #     * suite_ticket
    #     * suite_access_token
    #     * suite_access_token_expired_at

    BASE_URL = 'https://qyapi.weixin.qq.com'

    def self.included(host_class)
      host_class.include Jingubang::HttpClient
      host_class.base_url BASE_URL
      host_class.extend Jingubang::Weixin::Qiye::ProviderAppAccount::API
      host_class.extend ClassMethods
    end

    module ClassMethods

      def test_mode?
        test_mode
      end

      def refreshed_access_token
        return suite_access_token unless access_token_expired?
        refreshed_access_token!
      end

      def pre_auth_code
        code = get_pre_auth_code
        set_test_auth_mode(code) if test_mode?
        code
      end

      private

      def access_token_expired?
        !(suite_access_token_expired_at && suite_access_token_expired_at >= Time.now)
      end

      def refreshed_access_token!
        result = get_suite_access_token
        token = result[:suite_access_token]
        self.suite_access_token = token
        self.suite_access_token_expired_at = Time.now + result[:expires_in].seconds
        token
      end

    end
  end
end
