ApplicationService.factory "instagramAPI", ($http) ->

	USER = {
		accessId: "255614267",
		accessToken: "255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063"
		clientId: "fadd55ae5bf148c8b0f36d9f3d824d46"
	}

	instagramAPI = (options) ->
		@photos = []
		@profile = []
		@users = []
		@loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>')
		@busy = false
		base_url = "https://api.instagram.com/v1"
		switch options.filter
			when 'feed'
				@url = "#{base_url}/users/self/feed?count=30&access_token=#{USER.accessToken}"
			when 'popular'
				@url = "#{base_url}/media/popular?client_id=#{USER.clientId}"
			when 'follows'
				@url = "#{base_url}/users/#{USER.accessId}/follows?access_token=#{USER.accessToken}"
			when 'followed-by'
				@url = "#{base_url}/users/#{USER.accessId}/followed-by?access_token=#{USER.accessToken}"
			when 'users-recent'
				@url = "#{base_url}/users/#{options.user_id}/media/recent?access_token=#{USER.accessToken}"
			else
				@url = "#{base_url}/users/self/media/#{options.filter}?count=30&access_token=#{USER.accessToken}"

		return


	instagramAPI::fetchUsers = ->
		$('#instagram').parent().append(@loading)
		profile_url = "https://api.instagram.com/v1/users/255614267?access_token=255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063"
		$http.get(profile_url).success (data) =>
			@profile = data.data
			$http.get(@url).success (data) =>
				@users = @users.concat(data.data)
				$('.loading').remove()
				return
		return


	instagramAPI::firstPage = ->
		$('#instagram').parent().append(@loading)
		profile_url = "https://api.instagram.com/v1/users/255614267?access_token=255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063"
		$http.get(profile_url).success (data) =>
			@profile = data.data
			$http.get(@url).success (data) =>
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
