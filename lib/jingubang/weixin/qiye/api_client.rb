require 'rest_client'

module Jingubang::Weixin::Qiye
  class ApiClient

    GATEWAY_URL = 'https://qyapi.weixin.qq.com'

    class << self

      def get_login_info(access_token, auth_code)
        path = "/cgi-bin/service/get_login_info?access_token=#{access_token}"
        fire_request path, {auth_code: auth_code}
      end

      def get_register_code(access_token, template_id)
        path = "/cgi-bin/service/get_register_code?provider_access_token=#{access_token}"
        response = fire_request path, {template_id: template_id}
        response['register_code']
      end

      private

      def fire_request path, params
        url = "#{GATEWAY_URL}#{path}"
        response = JSON.parse RestClient.post(
          url,
          params.to_json,
          timeout: 10,
          content_type: :json,
          accept: :json
        )
        response&.with_indifferent_access
      end

    end

  end
end
