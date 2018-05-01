module Jingubang::Weixin::Qiye::Account
  module SendMessage

    def send_text_message userids: [], content: nil
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: userids_param(userids),
        msgtype: 'text',
        agentid: agentid,
        text: {
          content: content
        }
      }
      response = fire_request path, body
    end

    def send_text_card_message userids: [], title: nil, description: nil, url: nil, button_text: '详情'
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: userids_param(userids),
        msgtype: 'textcard',
        agentid: agentid,
        textcard: {
          title: title,
          description: description,
          url: url,
          btntxt: button_text
        }
      }
      response = fire_request path, body
    end

    def send_news_message userids: [], title: nil, description: nil, url: nil, button_text: '详情', image_url: nil
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: userids_param(userids),
        msgtype: 'news',
        agentid: agentid,
        news: {
          articles: [{
            title: title,
            description: description,
            url: url,
            picurl: image_url,
            btntxt: button_text
          }]
        }
      }
      response = fire_request path, body
    end

    private

    def userids_param userids
      userids.join('|')
    end

  end
end
