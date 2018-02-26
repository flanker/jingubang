module Jingubang
  module Test
    module TestHelper

      def build_qiye_weixin_test_notification echostr, encryptor
        encrypted_payload, timestamp, nonce, signature = encryptor.encrypt_with_signature(echostr)

        {
          'echostr' => encrypted_payload,
          'msg_signature' => signature,
          'timestamp' => timestamp,
          'nonce' => nonce
        }
      end

      def build_qiye_weixin_notification message, encryptor
        encrypted_payload, timestamp, nonce, signature = encryptor.encrypt_with_signature(message)

        {
          'xml' => {
            'ToUserName' => 'testusername',
            'Encrypt' => encrypted_payload
          },
          'msg_signature' => signature,
          'timestamp' => timestamp,
          'nonce' => nonce
        }
      end

    end
  end
end
