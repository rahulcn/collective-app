ApplicationController.controller "InstagramController", ($scope, $location, instagramAPI, $routeParams, $timeout) ->

	$scope.setActive(['instagram', $routeParams.filter])
	$scope.service = new instagramAPI($routeParams)
	signed_in = !_.isNull(window.localStorage.getItem('in_user'))

	if signed_in
		$location.path('/instagram/feed') if _.isEmpty($routeParams.filter)
	else
		$location.path('/instagram')

	if signed_in
		switch $routeParams.filter
			when 'follows'
				$scope.service.fetchUsers()
			when 'followed-by'
				$scope.service.fetchUsers()
			else
				$scope.service.firstPage()

	$scope.login = ->
		$scope.service.login()

	$scope.comment = {}
	$scope.comment.text = "Comment ... "
	$scope.commentCreate = (event) ->
		text = $('input', event.currentTarget).val()
		console.log "--> Submitting form"

		return

	$scope.popHeart = (event) ->
		@elem = $(event.target)
		popSize = [ 50, 40 ]
		margin = 14 / 2
		i = 0
		total = 14 * 2

		@elem.toggleClass('heart-active')

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

		if @elem.hasClass('heart-active')
			create()

		$scope.service.likeToggle({media_id: @elem.parent().parent().data('id'), method: @elem.data('method')})

		return
	return
