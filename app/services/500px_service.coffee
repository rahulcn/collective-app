ApplicationService.factory "fhpxAPI", ($http) ->
	KEY = {fhpx: 'pcVeKhKdsQoORanPjZGnGz9Li0XGiihd2X7XnBJj'}

	fhpxAPI = (options) ->
		@photos = []
		@loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>')
		@busy = false
		@category = options.category
		@only = options.only
		@exclude = if options.category != 'Nude' then '' else 'Nude'
		return

	fhpxAPI::firstPage = ->
		$('#grids').parent().append(@loading)
		url = "https://api.500px.com/v1/photos?feature=#{@category}&page=#{@page}&only=#{encodeURIComponent(@only)}&rpp=40&exclude=#{@exclude}&image_size[]=3&image_size[]=4&consumer_key=#{KEY['fhpx']}"
		$http.get(url).success (data) =>
			@photos = @photos.concat(data.photos)
			window.localStorage.setItem('ca_photos', JSON.stringify(@photos))
			$('.loading').remove()
			return
		return

	fhpxAPI::nextPage = ->
		return  if @busy
		$('#grids').parent().append(@loading)
		@busy = true
		@page = 2 unless @page
		url = "https://api.500px.com/v1/photos?feature=#{@category}&page=#{@page}&only=#{encodeURIComponent(@only)}&rpp=40&exclude=#{@exclude}&image_size[]=3&image_size[]=4&consumer_key=#{KEY['fhpx']}"
		$http.get(url).success (data) =>
			@photos = @photos.concat(data.photos)
			@page = @page + 1
			@busy = false
			$('.loading').remove()
			return

		return

	fhpxAPI
