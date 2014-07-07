angular.module('CollectiveApp.controllers', []).controller "dribbleController", ($scope, dribbleAPI) ->
	$scope.shots = []

	dribbleAPI.getShots().success (response) ->
		$scope.shots = response.shots

