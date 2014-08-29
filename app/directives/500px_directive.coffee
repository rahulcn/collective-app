ApplicationDirective.directive("ngRepeatEnd", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		if scope.$last is true
			$timeout ->
				scope.$emit "show"
				return

		return
)

ApplicationDirective.directive("infiScroll", ($timeout) ->
	restrict: "A"
	link: (scope, elm, attr) ->
		$timeout (->
			scroll_container = $(document)
			callMore = true
			newHeight = undefined
			handler = ->
				docHeight = scroll_container.height()
				winHeight = $(window).height() + 1000
				scrolledHeight = scroll_container.scrollTop()
				elmHeight = $(elm).height()

				#closure to compare elem height, which is changed when api loads feeds
				(=>
					if docHeight <= (winHeight + scrolledHeight)
						unless newHeight is elmHeight
							scope.$eval attr.infiScroll
							newHeight = elmHeight
					return
				)()
				return

			scroll_container.on "scroll", handler
			#on scolling, show/animate timeline blocks when enter the viewport
			scroll_container.on "scroll", ->
				$(".cd-timeline-block").each ->
					$(this).find(".cd-timeline-img, .cd-timeline-content").removeClass("is-hidden").addClass "bounce-in"  if $(this).offset().top <= $(window).scrollTop() + $(window).height() * 0.75 and $(this).find(".cd-timeline-img").hasClass("is-hidden")
					return

				return
			scope.$on "$destroy", ->
				scroll_container.off "scroll", handler #remove handler when scope is destroyed

			return
		), 300
		return
)

