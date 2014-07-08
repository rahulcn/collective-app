angular.module("CollectiveApp.directives", [])

.directive("ngRepeatEnd", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		if scope.$last is true
			$timeout ->
				scope.$emit "show"
				return

		return
)

.directive("whenScrolled", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		$timeout ->
			raw = element[0]
			$(window).bind "scroll", ->
				if (raw.scrollTop + raw.offsetHeight) >= raw.scrollHeight
					scope.$apply attr.whenScrolled
					return

		return
)

