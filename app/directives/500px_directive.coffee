ApplicationDirective.directive("ngRepeatEnd", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		if scope.$last is true
			$timeout ->
				scope.$emit "show"
				return

		return
)

ApplicationDirective.directive("whenScrolled", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		$timeout (->
			raw = element[0]
			$(window).bind "scroll", ->
				if (raw.scrollTop + raw.offsetHeight) >= raw.scrollHeight
					scope.$apply attr.whenScrolled
					return
		), 300
		return
)

ApplicationDirective.directive("infiScroll", ($timeout) ->
	restrict: "A"
	link: (scope, elm, attr) ->
		$timeout (->
			callMore = true
			newHeight = undefined
			handler = ->
				docHeight = $(document).height() - 100
				winHeight = $(window).height()
				scrolledHeight = $(document).scrollTop()
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

			$(document).on "scroll", handler
			scope.$on "$destroy", ->
				loading = $('<div class="col-xs-10 loading" style="display: block;height: 50px;">Loading ...</div>')
				$(elm).append(loading)
				$(document).off "scroll", handler #remove handler when scope is destroyed

			return
		), 300
		return
)