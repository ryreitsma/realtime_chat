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
