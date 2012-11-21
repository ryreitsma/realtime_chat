object @message
attributes :id, :created_at, :content
node :user do |message| 
  partial("users/user", object: message.user)
end
