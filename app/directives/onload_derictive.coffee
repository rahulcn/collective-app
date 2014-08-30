ApplicationDirective.directive "onLoad", ->
	link: (scope, element, attrs) ->
		element.bind "load", (e) ->

			if element.parent().parent().parent().parent().hasClass('shot-cam-loader')
				img = element.parent().parent().parent().parent()
			else
				img = element.parent().parent().parent()
				element.parent().parent().removeClass('shot-cam-loader')

			img.removeClass('shot-cam-loader')
			$('.spinner', img).fadeOut()
			return
		return