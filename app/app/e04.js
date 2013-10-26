angular.module("e04", [])
.controller('e04PersonCtrl', [ '$scope', '$state', 'Hub', 'angularFireCollection', function($scope, $state, Hub, angularFireCollection) {
	var firebase = new Firebase(window.global.config.FIREBASE);
	var person = angularFireCollection(firebase.child('people').child($state.params.person), function(snapshot) {
		$scope.person = snapshot.val();
		console.log($scope.person);
	});
}]);

