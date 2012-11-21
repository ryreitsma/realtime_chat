# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
HttpRouter.new do
  add('/push/').to(HomeAction)
  add('/push/message').to(MessageAction)
end
