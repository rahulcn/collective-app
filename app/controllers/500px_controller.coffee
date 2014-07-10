ApplicationController.controller "500pxController", ($scope, fhpxAPI, $routeParams) ->
	$scope.setActive(['fhpx', $routeParams.category])
	$scope.service = new fhpxAPI({category: $routeParams.category})
	$scope.service.nextPage()
	return
