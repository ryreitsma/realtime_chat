class MessagePublisher < ActiveRecord::Observer
  include Rails.application.routes.url_helpers
  observe :message
    
  def after_create(message)
    publisher = Redis.new(:host => 'localhost', :port => 6379)
    message_json = Rabl.render(message, 'messages/message', :view_path => 'app/views', :format => :json) 
    publisher.publish('chat', message_json)
    Rails.logger.info("Chat message #{message_json} published")
  end     
end
