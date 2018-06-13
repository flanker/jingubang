module Jingubang::Weixin::Qiye::Account
  module API

    def fetch_own_access_token
      path = "/cgi-bin/gettoken?corpid=#{corp_id}&corpsecret=#{corp_secret}"
      fire_request path, {}
    end

    def fetch_jsapi_ticket access_token
      path = "/cgi-bin/get_jsapi_ticket?access_token=#{access_token}"
      response = fire_request path, {}
      return response[:ticket], response
    end

    def fetch_user_id code
      path = "/cgi-bin/user/getuserinfo?access_token=#{refreshed_access_token}&code=#{code}"
      response = fire_request path, {}
      response[:UserId]
    end

    def fetch_user_info user_id
      path = "/cgi-bin/user/get?access_token=#{refreshed_access_token}&userid=#{user_id}"
      fire_request path, {}
    end

    def fetch_department_list
      path = "/cgi-bin/department/list?access_token=#{refreshed_access_token}"
      response = fire_request path, {}
      response[:department] if response[:errcode]&.zero?
    end

    def fetch_user_list department_id, fetch_child: false
      fetch_child_param = fetch_child ? 1 : 0
      path = "/cgi-bin/user/list?access_token=#{refreshed_access_token}&department_id=#{department_id}&fetch_child=#{fetch_child_param}"
      response = fire_request path, {}
      response[:userlist] if response[:errcode]&.zero?
    end

  end
end
