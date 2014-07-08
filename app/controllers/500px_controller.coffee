angular.module('CollectiveApp.controllers', ['CollectiveApp.directives']).controller(
	"500pxController", ($scope, $timeout, fhpxAPI) ->
		$scope.fhpx = new fhpxAPI()
		$scope.fhpx.nextPage()

		$scope.$on "show", (event) ->
			new AnimOnScroll(document.getElementById("grids"),{
				minDuration: 0.4
				maxDuration: 0.7
				viewportFactor: 0.2
			})
			if $scope.fhpx.photos.length <= 20
				console.log 'lightbox loading...'
				$(".grid a").imageLightbox
					onStart: ->
						overlayOn()
						closeButtonOn this
						return

					onLoadStart: ->
						activityIndicatorOn()
						return

					onLoadEnd: ->
						activityIndicatorOff()
						return

					onEnd: ->
						overlayOff()
						closeButtonOff()
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

		return
)