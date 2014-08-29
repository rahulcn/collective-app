ApplicationController.controller "ApplicationController", ($scope) ->
	$scope.lightboxActive = false
	$scope.setActive = (options = []) ->
		$scope.fhpxActive = ''
		$scope.popularActive = ''
		$scope.upcomingActive = ''
		$scope.editorsActive = ''
		$scope.fresh_todayActive = ''
		$scope.dribbleActive = ''
		$scope.instagramActive = ''
		$scope.feedActive = ''
		$scope.likedActive = ''
		$scope.recentActive = ''
		angular.forEach(options, (key, value) ->
			$scope[key + 'Active'] = 'btn-active'
		)

	$scope.toggleSettings = ->
		$('#settings').toggle()
		$('.container-fluid > .row:first-child').toggleClass('inactive')

	$scope.$on "show", (event) ->
		current_scope = $scope.$$listeners.show[0].arguments[0].targetScope
		# working on IScroll functionality
		#current_scope.$parent.myScroll["wrapper"].refresh()

		#hide timeline blocks which are outside the viewport
		$(".cd-timeline-block").each ->
			$(this).find(".cd-timeline-img, .cd-timeline-content").addClass "is-hidden"  if $(this).offset().top > $(window).scrollTop() + $(window).height() * 0.75
			return

		$('.loading').remove()

		if ($(window).width() > 1500) then $('.grid').addClass('col-md-2') else $('.grid').addClass('col-md-3')
		if ($('#grids').data('grid') == "user")
			$('.grid').removeClass('col-md-2 col-md-3').addClass('col-md-4')

		if $("#grids").length > 0
			new AnimOnScroll(document.getElementById("grids"),{
				minDuration: 0.4
				maxDuration: 0.7
				viewportFactor: 0.2
			})

#		$(".classysocial").ClassySocial()

		if current_scope.service.photos.length >= 40
			$scope.lightboxModel.loadImages($(".grid a.lightbox")) if $scope.lightboxActive
			$scope.lightbox() unless $scope.lightboxActive

		console.log("Hey you! Bamboo seeker!")
		console.log("I'd like to hear from you :)")
		console.log("Talk to me @ richesrahul@gmail.com")
		return

	# image lightbox code

	$scope.lightbox = ->
		$scope.lightboxActive = true
		$scope.lightboxModel = $(".grid a.lightbox").imageLightbox
			onStart: ->
				overlayOn()
				#closeButtonOn this
				return

			onLoadStart: ->
				activityIndicatorOn()
				return

			onLoadEnd: ->
				activityIndicatorOff()
				return

			onEnd: ->
				overlayOff()
				#closeButtonOff()
				activityIndicatorOff()
				return
		return

	activityIndicatorOn = ->
		$("<div id=\"imagelightbox-loading\"><div></div></div>").appendTo "body"
		return

	activityIndicatorOff = ->
		$("#imagelightbox-loading").remove()
		return

	overlayOn = ->
		$("<div id=\"imagelightbox-overlay\"></div>").appendTo "body"
		return

	overlayOff = ->
		$("#imagelightbox-overlay").remove()
		return

	closeButtonOn = (instance) ->
		$("<a href=\"#\" id=\"imagelightbox-close\">Close</a>").appendTo("body").on "click", ->
			$(this).remove()
			instance.quitImageLightbox()
			false
		return

	closeButtonOff = ->
		$("#imagelightbox-close").remove()
		return

	captionOn = ->
		description = $("a[href=\"" + $("#imagelightbox").attr("src") + "\"] img").attr("alt")
		$("<div id=\"imagelightbox-caption\">" + description + "</div>").appendTo "body"  if description.length > 0
		return

	captionOff = ->
		$("#imagelightbox-caption").remove()
		return

