class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  
  def index
    @messages = Message.order("created_at DESC")
  end
  
  def write
    message = current_user.write_message(params['content'])
    render text: 'OK'
  end            
end
