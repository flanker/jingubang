module Jingubang::Weixin::Qiye::Account
  module SendMessage

    def send_text_message departmentids: [], userids: [], content: nil
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: ids_param(userids),
        toparty: ids_param(departmentids),
        msgtype: 'text',
        agentid: agentid,
        text: {
          content: content
        }
      }
      response = fire_request path, body
    end

    def send_text_card_message departmentids: [], userids: [], title: nil, description: nil, url: nil, button_text: '详情'
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: ids_param(userids),
        toparty: ids_param(departmentids),
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

    def send_news_message departmentids: [], userids: [], title: nil, description: nil, url: nil, button_text: '详情', image_url: nil
      path = "/cgi-bin/message/send?access_token=#{refreshed_access_token}"
      body = {
        touser: ids_param(userids),
        toparty: ids_param(departmentids),
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

    def ids_param ids
      ids.join('|') if ids
    end

  end
end
