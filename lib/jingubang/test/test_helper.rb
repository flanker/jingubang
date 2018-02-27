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

      class ApiResult

        class << self

          def build_weixin_qiye_login_info corpid: 'thecorpid', userid: 'theuserid', error_code: nil
            return build_weixin_qiye_error_result(error_code) if error_code
            {
              usertype: 1,
              user_info: {
                userid:  userid,
                name: 'User Name',
                email: 'user@test.com',
                avatar: 'http://p.qlogo.cn/bizmail/thelinktouseravatar/0'
              },
              corp_info: {
                corpid: corpid
              },
              agent: [
                {agentid: 1000010, auth_type: 1},
                {agentid: 1000029, auth_type: 1}
              ],
              auth_info: {
                department: [
                  {id: 1, writable: true}
                ]
              }
            }
          end

          private

          def build_weixin_qiye_error_result error_code
            {
              errcode: error_code,
              errmsg: 'invalid code, hint: [1519698145_8_22f41dcc18e2ca451dd57b93b129b35d], more info at https://open.work.weixin.qq.com/devtool/query?e=40029',
              agent: []
            }
          end

        end
      end

    end
  end
end
