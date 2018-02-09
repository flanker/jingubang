module ActionDispatch::Routing
  class Mapper

    def with_jingubang
      jingubang_weixin_qiye
    end

    private

    def jingubang_weixin_qiye
      namespace 'weixin' do
        namespace 'qiye' do
          resources :notifications, only: [:index, :create]
        end
      end
    end

  end
end
