module Jingubang::Weixin::Qiye::Provider
  class NotificationsController < ::Jingubang::Weixin::Qiye::EncryptedMessageController

    def create
      render plain: 'success'
    end

  end
end
