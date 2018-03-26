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

      def log message
        Jingubang.logger.info message
      end

      def fire_request path, params, base_url: nil
        base_url = api_base_url unless base_url
        url = "#{base_url}#{path}"

        log "Jingubang sending request to: #{url}"
        log "    with params: #{params}"

        response = JSON.parse RestClient.post(
          url,
          params.to_json,
          timeout: 5,
          :content_type => :json,
          :accept => :json
        )

        log "Jingubang response: #{response}"

        response&.with_indifferent_access
      end
    end

    def fire_request path, params
      self.class.fire_request path, params, base_url: self.class.api_base_url
    end

  end
end
