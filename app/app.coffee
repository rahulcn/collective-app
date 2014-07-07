angular.module('CollectiveApp', [
	'CollectiveApp.controllers',
	'CollectiveApp.services',
	'CollectiveApp.directives',
	'infinite-scroll'
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

