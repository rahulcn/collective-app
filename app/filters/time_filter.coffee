ApplicationDirective.filter("fromNow", ->
	(date) ->
		moment.unix(date).startOf('hour').fromNow()
)