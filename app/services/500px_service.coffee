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
		$http.get(url).success (data) =>
			@photos = @photos.concat(data.photos)
			@page = @page + 1
			@busy = false
			return

		return

	fhpxAPI
