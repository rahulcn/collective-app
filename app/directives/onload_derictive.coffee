ApplicationDirective.directive "onLoad", ->
	link: (scope, element, attrs) ->
		element.bind "load", (e) ->
			img = $('.shot-cam-loader')
			img.removeClass('shot-cam-loader')
			$('.spinner', img).fadeOut()
			return
		return