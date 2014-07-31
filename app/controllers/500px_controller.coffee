ApplicationController.controller "500pxController", ($scope, $location, fhpxAPI, $routeParams) ->
	path = $location.path().split('/')[2]
	$scope.setActive(['fhpx', path])
	$scope.service = new fhpxAPI({category: path})
	unless window.localStorage.getItem('ca_photos')
		$scope.service.firstPage()
	else
		$scope.service.photos = JSON.parse(window.localStorage.getItem('ca_photos'))
	return
