angular.module('CollectiveApp.services', []).factory "dribbleAPI", ($http) ->
	dribbleAPI = {}
	dribbleAPI.getShots = ->
		$http.get('../assets/data/everyone.json')

	dribbleAPI



