ApplicationDirective.directive "onLoad", ->
	link: (scope, element, attrs) ->
		element.bind "load", (e) ->

			if element.parent().parent().parent().hasClass('shot-cam-loader')
				img = element.parent().parent().parent()
			else
				img = element.parent().parent()
			img.removeClass('shot-cam-loader')
			$('.spinner', img).fadeOut()
			return
		return