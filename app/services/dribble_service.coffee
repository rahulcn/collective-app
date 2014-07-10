#ApplicationService.factory "dribbleAPI", ($http) ->
#	dribbleAPI = {}
#	dribbleAPI.getShots = ->
#		$http.get('../assets/data/everyone.json')
#
#	dribbleAPI

ApplicationService.factory "dribbleAPI", ($http) ->

	API = (options) ->
		@photos = []
		@busy = false
		@category = options.category
		return

	API::nextPage = ->
		return  if @busy
		@busy = true
		@page = 1 unless @page
		url = "http://api.dribbble.com/shots/#{@category}?page=#{@page}&per_page=20"
		$http.get(url).success (data) =>
			@photos = @photos.concat(data.shots)
			@page = @page + 1
			@busy = false
			return

		return

	API


