ApplicationDirective.directive "onLoad", ->
	link: (scope, element, attrs) ->
		element.bind "load", (e) ->
			shot = element.parent().parent().parent()
			shot.removeClass('shot-cam-loader')
			$('.spinner', shot).fadeOut()
			return
		return