ApplicationController.controller "InstagramController", ($scope, $location, instagramAPI, $routeParams, $timeout) ->

	$scope.setActive(['instagram', $routeParams.filter])
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


	$scope.popHeart = (event) ->
		@elem = $(event.target)
		popSize = [ 50, 40 ]
		teaserSize = [ 24, 24 ]
		margin = 14 / 2
		i = 0
		total = 14 * 2

		position = (heart, size) =>
			w = @elem.parent()
			minX = w.scrollLeft() + margin
			maxX = w.scrollLeft() + w.width() - size[0] - margin
			minY = w.scrollTop() + margin
			maxY = w.scrollTop() + w.height() - size[1] - margin
			heart.css "left", Math.round(minX + Math.random() * (maxX - minX)) + "px"
			heart.css "top", Math.round(minY + Math.random() * (maxY - minY)) + "px"
			return

		create = =>
			++i
			heart = $("<div class=\"heart heart-active pop\"></div>")
			heart.bind "animationend oanimationend MSAnimationEnd " + "mozAnimationEnd webkitAnimationEnd", ->
				$(this).remove()
				return

			position heart, popSize
			heart.appendTo @elem.parent()
			if i < total
				setTimeout create, Math.random() * 250
			return

		create()
		return
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
