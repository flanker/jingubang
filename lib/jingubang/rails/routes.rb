module ActionDispatch::Routing
  class Mapper

    def with_jingubang options
      init_jingubang_weixin_qiye_routes options
    end

    private

    def init_jingubang_weixin_qiye_routes options
      notifications_controller = options[:notifications] ? options[:notifications] : 'jingubang/weixin/qiye/notifications'
      account_notifications_controller = options[:account_notifications] ? options[:account_notifications] : 'jingubang/weixin/qiye/account_notifications'
      provider_notifications_controller = options[:provider_notifications] ? options[:provider_notifications] : 'jingubang/weixin/qiye/provider/notifications'

      scope :weixin do
        scope :qiye do
          resources :notifications, controller: notifications_controller, only: [:index, :create]

          resources :corps, only: [] do
            resources :notifications, controller: account_notifications_controller, only: [:index, :create]
          end

          namespace :provider do
            resources :notifications, controller: account_notifications_controller, only: [:index, :create]
          end
        end
      end
    end

  end
end
