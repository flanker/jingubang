require 'jingubang/weixin/qiye/account/send_message'

module Jingubang::Weixin::Qiye
  module Account

    # Required fields:
    #   field :access_token, type: String
    #   field :expired_at, type: Time
    #   field :permanent_code, type: String
    #   def refreshed_access_token

    ROOT_DEPARTMENT_ID = 1

    include Account::SendMessage

    BASE_URL = 'https://qyapi.weixin.qq.com'

    def self.included(host_class)
      host_class.include Jingubang::HttpClient
      host_class.base_url BASE_URL
    end

    # API methods:

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

    def fetch_all_user_list
      fetch_user_list ROOT_DEPARTMENT_ID, fetch_child: true
    end

    def fetch_user userid
      path = "/cgi-bin/user/get?access_token=#{refreshed_access_token}&userid=#{userid}"
      response = fire_request path, {}
    end

  end
end
