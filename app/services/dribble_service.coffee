ApplicationService.factory "dribbleAPI", ($http) ->

	API = (options) ->
		@photos = []
		@busy = false
		@category = options.category
		return

	API::nextPage = ->
		return  if @busy
		loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>')
		$('#grids').parent().append(loading)
		@busy = true
		@page = 1 unless @page
		url = "https://api.dribbble.com/shots/#{@category}?page=#{@page}&per_page=20&callback=JSON_CALLBACK"
		$http.jsonp(url).success (data) =>
			@photos = @photos.concat(data.shots)
			@page = @page + 1
			@busy = false
			$('.loading').remove()
			return

		return

	API


