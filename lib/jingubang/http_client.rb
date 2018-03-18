require 'rest_client'

module Jingubang
  module HttpClient

    def self.included(host_class)
      host_class.extend ClassMethods
    end

    module ClassMethods

      # e.g. 'https://qyapi.weixin.qq.com'
      def base_url url
        @api_base_url = url
      end

      def api_base_url
        @api_base_url
      end
    end

    def fire_request path, params
      url = "#{self.class.api_base_url}#{path}"

      Jingubang.logger.info "Jingubang sending request to: #{url}"
      Jingubang.logger.info "    with params: #{params}"

      response = JSON.parse RestClient.post(
        url,
        params.to_json,
        timeout: 5,
        :content_type => :json,
        :accept => :json
      )

      Jingubang.logger.info "Jingubang response: #{response}"

      response&.with_indifferent_access
    end

  end
end
