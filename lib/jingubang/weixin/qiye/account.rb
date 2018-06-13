require 'jingubang/weixin/qiye/account/api'
require 'jingubang/weixin/qiye/account/send_message'

module Jingubang::Weixin::Qiye
  module Account

    # Required fields:
    #   field :corpid, type: String
    #   field :access_token, type: String
    #   field :expired_at, type: Time
    #   field :permanent_code, type: String
    #   def refreshed_access_token

    ROOT_DEPARTMENT_ID = 1

    include Account::API
    include Account::SendMessage

    BASE_URL = 'https://qyapi.weixin.qq.com'

    def self.included(host_class)
      host_class.include Jingubang::HttpClient
      host_class.base_url BASE_URL
    end

    def refreshed_access_token
      return access_token if expired_at && expired_at >= Time.now
      refresh_access_token!
    end

    def refreshed_own_access_token
      return own_access_token if own_access_token_expired_at && own_access_token_expired_at >= Time.now
      refresh_own_access_token!
    end

    def refreshed_jsapi_ticket
      return jsapi_ticket if jsapi_ticket_expired_at && jsapi_ticket_expired_at > Time.now
      refresh_jsapi_ticket!
    end

    def refreshed_own_jsapi_ticket
      return own_jsapi_ticket if own_jsapi_ticket_expired_at && own_jsapi_ticket_expired_at > Time.now
      refresh_own_jsapi_ticket!
    end

    def jsapi_params url, use_own_jsapi_ticket = true
      jsapi_ticket = use_own_jsapi_ticket ? refreshed_own_jsapi_ticket : refreshed_jsapi_ticket
      timestamp = Time.now.to_i
      noncestr = SecureRandom.urlsafe_base64(12)
      signature = sign_params timestamp: timestamp, noncestr: noncestr, jsapi_ticket: jsapi_ticket, url: url
      {
        appid: corp_id,
        timestamp: timestamp,
        noncestr: noncestr,
        signature: signature,
        url: url
      }
    end

    private

    def refresh_access_token!
      response = Weixin::Qiye::SystemAccount.get_corp_access_token(corpid, permanent_code)
      self.set access_token: response[:access_token], expired_at: expired_at_from_response(response)
      access_token
    end

    def refresh_own_access_token!
      response = fetch_own_access_token
      self.set own_access_token: response[:access_token], own_access_token_expired_at: expired_at_from_response(response)
      access_token
    end

    def refresh_jsapi_ticket!
      ticket, response = fetch_jsapi_ticket(refreshed_access_token)
      return if ticket.blank?

      self.set jsapi_ticket: ticket, jsapi_ticket_expired_at: expired_at_from_response(response)
      ticket
    end

    def refresh_own_jsapi_ticket!
      ticket, response = fetch_jsapi_ticket(refreshed_own_access_token)
      return if ticket.blank?

      self.set own_jsapi_ticket: ticket, own_jsapi_ticket_expired_at: expired_at_from_response(response)
      ticket
    end

    def expired_at_from_response response
      response[:expires_in] ? 3.minutes.ago + response[:expires_in].seconds : Time.current
    end

    def fetch_all_user_list
      fetch_user_list ROOT_DEPARTMENT_ID, fetch_child: true
    end

    def sign_params options
      to_be_singed_string = options.sort.map { |key, value| "#{key}=#{value}" }.join('&')
      Digest::SHA1.hexdigest to_be_singed_string
    end

  end
end
