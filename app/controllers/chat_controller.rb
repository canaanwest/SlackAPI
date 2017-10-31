class ChatController < ApplicationController
  def index
    #lists all slack channels
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
    index.each do |channel|
      if channel.id == @channel
        @name = channel.name
      end
    end
  end

  def create
    SlackApiWrapper.send_message(params[:channel], params[:message])
    redirect_to root_path
  end
end
