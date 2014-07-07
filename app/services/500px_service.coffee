angular.module('CollectiveApp.services', []).factory "fhpxAPI", ($http) ->
	KEY = {fhpx: 'pcVeKhKdsQoORanPjZGnGz9Li0XGiihd2X7XnBJj'}

	fhpxAPI = ->
		@photos = []
		@busy = false
		return

	fhpxAPI::nextPage = ->
		return  if @busy
		@busy = true
		@page = 1 unless @page
		url = "https://api.500px.com/v1/photos?feature=editors&page=#{@page}&image_size[]=3&image_size[]=4&consumer_key=#{KEY['fhpx']}"
		$http.get(url).success ((data) =>
			photos = data.photos
			i = 0

			while i < photos.length
				@photos.push photos[i]
				i++
			@page = @page + 1
			@busy = false
			return
		).bind(this)
		return

	fhpxAPI

###

angular.module('CollectiveApp.services', []).factory "fhpxAPI", ($http) ->
	API = {}
	API.getPhotos = ->
		$http.get('https://api.500px.com/v1/photos?feature=editors&page=1&rpp=50&page=1&image_size[]=3&image_size[]=4&consumer_key=pcVeKhKdsQoORanPjZGnGz9Li0XGiihd2X7XnBJj')

	API
###