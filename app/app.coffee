Application.config([
	"$routeProvider"
	"$compileProvider"
	($routeProvider, $compileProvider) ->
		$compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|chrome-extension):/)
		$routeProvider
		.when("/500px/:category", {
			templateUrl: "templates/fhpx_view.html"
			controller: '500pxController'
		})
		.when('/dribble/:category', {
			templateUrl: 'templates/dribble_view.html'
			controller: 'DribbleController'
		})
		.otherwise({redirectTo: "/500px/popular"})
])


YTMenu = (->
	init = ->
		[].slice.call(document.querySelectorAll(".dr-menu")).forEach (el, i) ->
			trigger = el.querySelector("div.dr-trigger")
			icon = trigger.querySelector("i.fa-bars")
			open = false
			trigger.addEventListener "click", ((event) ->
				unless open
					el.className += " dr-menu-open"
					open = true
				return
			), false
			icon.addEventListener "click", ((event) ->
				if open
					event.stopPropagation()
					open = false
					el.className = el.className.replace(/\bdr-menu-open\b/, "")
					false
			), false
			return

		return
	init()
	return
)()

