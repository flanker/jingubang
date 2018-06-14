module Jingubang::Weixin::Qiye
  class NotificationsController < ::Jingubang::Weixin::Qiye::EncryptedMessageController

    def create
      Jingubang.logger.info "Weixin Qiye Message: #{@message_content}"

      case @message_content['InfoType']
        when 'suite_ticket'
          Jingubang.logger.info "Weixin::Qiye save suite ticket: #{@message_content['SuiteTicket']}"
          process_suite_ticket
        when 'create_auth'
          Jingubang.logger.info "Weixin::Qiye process create auth: #{@message_content['AuthCode']}"
          process_create_auth
        when 'cancel_auth'
          Jingubang.logger.info "Weixin::Qiye process cancel auth: #{@message_content['AuthCorpId']}"
          process_cancel_auth
        when 'change_auth'
          Jingubang.logger.info "Weixin::Qiye process change auth: #{@message_content['AuthCorpId']}"
          process_change_auth
        when 'change_contact'
          Jingubang.logger.info "Weixin::Qiye process change auth: #{@message_content['AuthCorpId']}"
          process_change_contact
      end

      render plain: 'success'
    end

    private

    def process_suite_ticket
    end

    def process_create_auth
    end

    def process_cancel_auth
    end

    def process_change_auth
    end

    def process_change_contact
    end

  end
end
