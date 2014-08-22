ApplicationService.factory "instagramAPI", ($http) ->

	USER = {
		accessId: "255614267",
		accessToken: "255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063"
	}

	instagramAPI = (options) ->
		@photos = []
		@profile = []
		@loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>')
		@busy = false
		if options.filter == 'feed' then filter = options.filter else filter = "media/#{options.filter}"
		@options = "#{filter}?count=30&access_token=#{USER.accessToken}"
		return


	instagramAPI::firstPage = ->
		$('#instagram').parent().append(@loading)
		profile_url = "https://api.instagram.com/v1/users/255614267?access_token=255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063"
		url = "https://api.instagram.com/v1/users/self/#{@options}"
		$http.get(profile_url).success (data) =>
			@profile = data.data
			$http.get(url).success (data) =>
				@next_url = data.pagination.next_url
				@photos = @photos.concat(data.data)
				window.localStorage.setItem('in_photos', JSON.stringify(@photos))
				$('.loading').remove()
				return
		return

	instagramAPI::nextPage = ->
		return  if @busy
		$('#grids').parent().append(@loading)
		@busy = true
		@page = 2 unless @page
		$http.get(@next_url).success (data) =>
			@next_url = data.pagination.next_url
			@photos = @photos.concat(data.data)
			@page = @page + 1
			@busy = false
			$('.loading').remove()
			return

		return

	instagramAPI
