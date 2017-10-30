class ChatController < ApplicationController
  def index
    #lists all slack channels
  end

  def new
    #lets you make a new message for the slack channel
  end

  def create
    #will create the message, post it to the channel, and redirect you back to the channel
  end
end
