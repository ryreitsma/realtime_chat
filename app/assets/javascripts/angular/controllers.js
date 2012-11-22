function MessagesController($scope, $http, socket){
  $scope.messages = $("#messages").data("messages");
  $scope.orderProp = "created_at";
  
  socket.on('message', function (message) {
    $scope.messages.push(message);
  }); 
  
  $scope.sendMessage = function(message){
    $http.post('http://localhost:3000/messages/write', message);
    $scope.message.content = "";
  }
}
