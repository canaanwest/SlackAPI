require "httparty"

class SlackApiWrapper
  # Your code here!
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    url = BASE_URL + "channels.list?token=#{TOKEN}" + "&exclude_archived=1"
    #to include channels that archived, make the 1 a 0 or leave off the exclude thign

    data = HTTParty.get(url)

    if data["channels"]
      my_channels = data["channels"].map do |channel_hash|
        Channel.new channel_hash["name"], channel_hash["id"],
        purpose: channel_hash["purpose"],
        is_archived: channel_hash["is_archived"],
        is_general: channel_hash["is_general"],
        members: channel_hash["members"]
      end
      return my_channels
    else
      return []
    end
  end

  def self.send_message(channel, message)
    puts "SENDing #{message} to channel #{channel}"

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"

    response = HTTParty.post(url, body: {
      "text" => "#{message}",
      "channel" => "#{channel}",
      "username" => "Shaunna Wiens",
      "icon_url" => "https://avatars.slack-edge.com/2017-05-02/178662997542_1d2e3a395ca76d065344_24.jpg",
      "as_user" => "false"
    },
    :headers => {'Content-Type' => "application/x-www-form-urlencoded"}
  )

  return response.success?
end

end
