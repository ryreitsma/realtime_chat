class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = Message.order("created_at DESC")
  end
  
  def write
    message = current_user.write_message(params['content'])
    redirect_to 'http://localhost:3000/messages/index'
  end
  
  def message
    message = Message.find(params[:message_id])
    render partial: "message", message: message
  end
          
end
