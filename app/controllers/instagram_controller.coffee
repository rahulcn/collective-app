ApplicationController.controller "InstagramController", ($scope, $location, instagramAPI, $routeParams, $timeout) ->

#	$('#selector').pongstgrm({
#		accessId: "richesrahul",
#		accessToken: "255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063",
#		show: "feed",
#		count: 20,
#		profile_bg_img: "http://pongstr.github.io/pongstagr.am/assets/img/img.jpg",
#		profile_bg_color: "#4F405F"
#	})


#	$scope.setActive(['fhpx', $routeParams.category])
	$scope.service = new instagramAPI($routeParams)
#	$('.hyperlink-nav li > a').data('main', $routeParams.category)
#	$scope.filters = ['Abstract', 'Macro', 'Animals', 'Nature', 'Black & White', 'Celebrities', 'People', 'City & Architecture', 'Performing Arts', 'Commercial', 'Sport', 'Concert', 'Still Life', 'Family', 'Street', 'Fashion', 'Transportation', 'Film', 'Travel', 'Fine Art', 'Underwater', 'Food', 'Urban Exploration', 'Journalism', 'Wedding', 'Landscapes', 'Uncategorized']

	switch $routeParams.filter
		when 'follows'
			$scope.service.fetchUsers()
		when 'followed-by'
			$scope.service.fetchUsers()
		else
			$scope.service.firstPage()


	#
#	$scope.selectCategory = ($event) =>
#		elem = $($event.target)
#		category = elem.data('category')
#		$('.link-active').removeClass('link-active')
#		elem.addClass('link-active')
#		$timeout (=>
#			$scope.$apply =>
#				$location.path("/500px/#{$('.hyperlink-nav li > a').data('main')}/#{category}").replace()
#				return
#		), 1
#
#
	return
