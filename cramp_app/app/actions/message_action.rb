require 'json'

class MessageAction < Cramp::Action
  self.transport = :websocket
  
  on_start :create_redis
  on_finish :destroy_redis
  
  use_fiber_pool :size => 1000
  
  def create_redis
    @sub = EM::Hiredis.connect("redis://localhost:6379")
    @sub.subscribe('chat')
    @sub.on(:message) do |channel, message|
    	render(message)
    end
  end
  
  def destroy_redis
    @sub.close_connection
  end
end
