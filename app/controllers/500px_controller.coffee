ApplicationController.controller "500pxController", ($scope, $location, fhpxAPI, $routeParams) ->
	console.log 'Scope', $scope
	console.log 'fhpxAPI', fhpxAPI
	console.log '$routeParams', $routeParams
	console.log '$location', $location

	path = $location.path().split('/')[2]
	$scope.setActive(['fhpx', path])
	$scope.service = new fhpxAPI({category: path})
	$scope.service.nextPage()
	return
