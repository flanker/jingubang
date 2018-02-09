module Weixin::Qiye
  class NotificationsController < ActionController::Base

    before_action :assign_payload, :verify_sign, :decrypt_payload, only: [:index, :create]
    before_action :assign_message, only: [:create]

    def index
      if service_verify?
        render plain: @payload
      else
        render nonthing: true, status: :bad_request
      end
    end

    def create
      Rails.logger.info "Weixin Qiye Message: #{@message['InfoType']}"
      case @message['InfoType']
        when 'suite_ticket'
          process_ticket_message
        # when 'authorized'
        # when 'unauthorized'
        # when 'updateauthorized'
        when 'contact_sync'
          process_contact_sync
      end

      render text: 'success'
    end

    private

    def assign_payload
      byebug
      @encrypted_payload = service_verify? ? params[:echostr] : params[:xml][:Encrypt]
    end

    def verify_sign
      render text: 'YOY', status: 401 unless params[:msg_signature] == calculated_sign
    end

    def calculated_sign
      salt = [
        @encrypted_payload,
        Jingubang::Setting.qiye[:token],
        params[:timestamp],
        params[:nonce]
      ].sort.join
      Digest::SHA1.hexdigest salt
    end

    def decrypt_payload
      key = Base64.decode64 Jingubang::Setting.qiye[:encoding_aes_key] + '='
      aes_msg = Base64.decode64 @encrypted_payload
      msg = AESCrypt.decrypt_data aes_msg, key, nil, 'AES-256-CBC'
      @payload = msg[20..-19]
    end

    def assign_message
      @message = Hash.from_xml(@payload)['xml']
    end

    def service_verify?
      params[:echostr].present?
    end

    def process_ticket_message
      Rails.logger.info "Weixin::Qiye save suite ticket: #{@message['SuiteTicket']}"
    end

    def process_contact_sync
      Rails.logger.info "Weixin::Qiye process contact sync: #{@message['AuthCorpId']}"
    end

  end
end
