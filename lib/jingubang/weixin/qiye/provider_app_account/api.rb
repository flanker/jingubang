module Jingubang::Weixin::Qiye::ProviderAppAccount
  module API

    def get_suite_access_token
      path = '/cgi-bin/service/get_suite_token'
      response = fire_request path, {suite_id: suite_id, suite_secret: suite_secret, suite_ticket: suite_ticket}
      {suite_access_token: response[:suite_access_token], expires_in: response[:expires_in]}
    end

    def get_pre_auth_code
      path = "/cgi-bin/service/get_pre_auth_code?suite_access_token=#{refreshed_access_token}"
      response = fire_request path, {suite_id: suite_id}
      response[:pre_auth_code]
    end

    def set_test_auth_mode code
      path = "/cgi-bin/service/set_session_info?suite_access_token=#{refreshed_access_token}"
      fire_request path, {pre_auth_code: code, session_info: {auth_type: 1}}
    end

    def get_permanent_code auth_code
      path = "/cgi-bin/service/get_permanent_code?suite_access_token=#{refreshed_access_token}"
      fire_request path, {auth_code: auth_code}
    end

    def get_corp_access_token corpid, permanent_code
      path = "/cgi-bin/service/get_corp_token?suite_access_token=#{refreshed_access_token}"
      fire_request path, {suite_id: suite_id, auth_corpid: corpid, permanent_code: permanent_code}
    end

    def get_auth_info corpid, permanent_code
      path = "/cgi-bin/service/get_auth_info?suite_access_token=#{refreshed_access_token}"
      fire_request path, {auth_corpid: corpid, permanent_code: permanent_code}
    end

    def get_login_info auth_code
      path = "/cgi-bin/service/get_login_info?access_token=#{refreshed_access_token}"
      fire_request path, {auth_code: auth_code}
    end

    def register_code
      path = "/cgi-bin/service/get_register_code?provider_access_token=#{refreshed_access_token}"
      response = fire_request path, {template_id: custom_registration_id}
      response[:register_code]
    end

  end
end
