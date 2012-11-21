require 'json'

class MessageAction < Cramp::Action
  self.transport = :sse
  
  on_start :create_redis
  on_finish :destroy_redis
  
  use_fiber_pool :size => 1000
  keep_connection_alive
  
  def respond_with
    [200, {'Content-Type' => 'application/json'}]
  end 
  
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
