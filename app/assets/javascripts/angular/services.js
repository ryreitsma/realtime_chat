app.factory('eventsource', function ($rootScope) {
  var eventSource = new EventSource('http://localhost:3000/push/message');
  return {
    on: function (eventName, callback) {
      eventSource.addEventListener(eventName, function (e) {  
        var data = JSON.parse(e.data);
				console.log(data.msg);
				$rootScope.$apply(function () {
	        callback.apply(eventSource, data);
	      });					
			}, false);
    }
  };
});

app.factory('socket', function ($rootScope) { 
  try {
    var socket = new WebSocket('ws://localhost:3001/push/message');
		socket.onopen = function(e){
		  console.log("opened a websocket connection");
		}
		socket.onerror = function(e){
		  console.log("error in websocket connection")
		}
		return {
		  on: function (eventName, callback) {
		    socket.onmessage = function (e) {  
		      var data = JSON.parse(e.data);
					console.log(data);
					$rootScope.$apply(function () {
			      callback(data);
			    });
		    }
		  }  
		};  
  } catch (exception) {
    console.log("Exception occurred in websocket" + exception);
  }
 
  
});
