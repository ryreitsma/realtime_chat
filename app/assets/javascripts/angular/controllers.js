function MessagesController($scope, eventsource){
  $scope.messages = $("#messages").data("messages"); 
  
  eventsource.on('message', function (message) {
    $scope.messages.push(message);
  }); 
}
