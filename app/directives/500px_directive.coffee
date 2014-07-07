angular.module("CollectiveApp.directives", []).directive("ngRepeatEnd", ($timeout) ->
	restrict: "A"
	link: (scope, element, attr) ->
		if scope.$last is true
			$timeout ->
				scope.$emit "show"
				return

		return
)