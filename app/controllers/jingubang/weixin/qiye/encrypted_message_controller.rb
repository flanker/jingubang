require 'weixin_message_encryptor'

module Jingubang::Weixin::Qiye
  class EncryptedMessageController < ::Jingubang::BaseController

    before_action :decrypt_payload_and_verify, only: [:index, :create]
    before_action :parse_xml_payload, only: [:create]

    def index
      return render plain: @message if service_verify?

      head :bad_request
    end

    def create
    end

    private

    def weixin_message_encryptor
      @weixin_message_encryptor ||= WeixinMessageEncryptor.new encoding_aes_key: Jingubang::Setting.qiye[:encoding_aes_key],
                                                               sign_token: Jingubang::Setting.qiye[:sign_token],
                                                               app_id: Jingubang::Setting.qiye[:suite_id]
    end

    def decrypt_payload_and_verify
      @message, _app_id, calculated_sign = weixin_message_encryptor.decrypt params
      head :bad_request unless params[:msg_signature] == calculated_sign
    end

    def service_verify?
      params[:echostr].present?
    end

    def parse_xml_payload
      @message_content = Hash.from_xml(@message)['xml']
    end

    def encrypted_user_text_response from_user_name, to_user_name, content
      response_content = "<xml><ToUserName><![CDATA[#{to_user_name}]]></ToUserName><FromUserName><![CDATA[#{from_user_name}]]></FromUserName><CreateTime>#{Time.now.to_i}</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[#{content}]]></Content></xml>"
      weixin_message_encryptor.encrypt_to_xml response_content
    end

  end
end
