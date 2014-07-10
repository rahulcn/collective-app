ApplicationController.controller "DribbleController", ($scope, dribbleAPI, $routeParams) ->
	$scope.setActive(['dribble', $routeParams.category])
	$scope.service = new dribbleAPI({category: $routeParams.category})
	$scope.service.nextPage()
	return

