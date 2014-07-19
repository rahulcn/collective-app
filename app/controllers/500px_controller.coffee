ApplicationController.controller "500pxController", ($scope, $location, fhpxAPI, $routeParams) ->
	path = $location.path().split('/')[2]
	$scope.setActive(['fhpx', path])
	$scope.service = new fhpxAPI({category: path})
	$scope.service.nextPage()
	return
