ApplicationService.factory "fhpxAPI", ($http) ->
	KEY = {fhpx: 'pcVeKhKdsQoORanPjZGnGz9Li0XGiihd2X7XnBJj'}

	fhpxAPI = (options) ->
		@photos = []
		@busy = false
		@category = options.category
		return

	fhpxAPI::nextPage = ->
		return  if @busy
		loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>')
		$('#grids').parent().append(loading)
		@busy = true
		@page = 1 unless @page
		url = "https://api.500px.com/v1/photos?feature=#{@category}&page=#{@page}&rpp=12&exclude=nude&image_size[]=3&image_size[]=4&consumer_key=#{KEY['fhpx']}"
		$http.get(url).success (data) =>
			@photos = @photos.concat(data.photos)
			@page = @page + 1
			@busy = false
			$('.loading').remove()
			return

		return

	fhpxAPI
