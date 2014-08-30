ApplicationService.factory "instagramAPI", ($http, $location) ->

	USER = {
		accessId: "255614267",
		clientId: "fadd55ae5bf148c8b0f36d9f3d824d46"
	}

	instagramAPI = (options) ->
		@access_token = JSON.parse(window.localStorage.getItem('in_user')).access_token if !_.isNull(window.localStorage.getItem('in_user'))
		@photos = []
		@profile = []
		@relationship = []
		@users = []
		@errors= []
		@loading = $('<div class="loading-heart-container"><div class="loading-heart"></div></div>')
		@busy = false
		base_url = "https://api.instagram.com/v1"
		console.log(options.filter)
		switch options.filter
			when 'feed'
				@url = "#{base_url}/users/self/feed?count=10&access_token=#{@access_token}"
			when 'popular'
				@url = "#{base_url}/media/popular?client_id=#{USER.clientId}"
			when 'follows'
				@url = "#{base_url}/users/#{options.user_id}/follows?access_token=#{@access_token}"
			when 'followed-by'
				@url = "#{base_url}/users/#{options.user_id}/followed-by?access_token=#{@access_token}"
			when 'user_id'
				@url = "#{base_url}/users/#{options.user_id}/media/recent?access_token=#{@access_token}"
			when 'recent'
				@url = "#{base_url}/users/#{options.user_id}/media/#{options.filter}?count=30&access_token=#{@access_token}"
			when 'liked'
				@url = "#{base_url}/users/self/media/#{options.filter}?count=30&access_token=#{@access_token}"


		return


	instagramAPI::fetchUsers = (params) ->
		$('#instagram').parent().append(@loading)
		@loading.css({'margin-top': '50px', 'margin-bottom': '50px'})
		profile_url = "https://api.instagram.com/v1/users/#{params.user_id}?access_token=#{@access_token}"
		$http.get(profile_url).success (data) =>
			@profile = data.data
			$http.get(@url).success (data) =>
				@users = @users.concat(data.data)
				$('.loading-heart-container').remove()
				return
		return


	instagramAPI::firstPage = (params) ->
		$('#instagram').parent().append(@loading)
		profile_url = "https://api.instagram.com/v1/users/#{params.user_id}?access_token=#{@access_token}"
		relationship_url = "https://api.instagram.com/v1/users/#{params.user_id}/relationship?access_token=#{@access_token}"
		$http.get(profile_url).success( (data) =>
			@profile = data.data
			if params.user_id isnt 'self'
				$http.get(relationship_url).success (data) =>
					@relationship = data.data
					return
			$http.get(@url).
			success( (data) =>
				@next_url = data.pagination.next_url
				@photos = @photos.concat(data.data)
				window.localStorage.setItem('in_photos', JSON.stringify(@photos))
				$('.loading-heart-container').remove()
				return
			)
		).
		error( (data) =>
			@errors = ['This account is private']
			$('.loading-heart-container').remove()
			$('#cd-timeline').removeClass('cd-timeline')
			$('.empty-object:first-child').hide()
		)
		return

	instagramAPI::likeToggle = (params) ->
		like_url = "https://api.instagram.com/v1/media/#{params.media_id}/likes?access_token=#{@access_token}"
		if params.method == "post"
			$http.post(like_url)
		else
			$http({url: like_url, method: 'DELETE'})
		return


	instagramAPI::comment = (params) ->
		comment_url = "https://api.instagram.com/v1/media/#{params.media_id}/comments"
		object = {access_token: @access_token, text: params.text}
		if params.method == "post"
			$["post"](comment_url, object).success (data) ->
				console.log("Commenting #{data} ...")
		else
			$http({url: comment_url, method: 'DELETE'})
		return


	instagramAPI::follow = (params) ->
		relationship_url = "https://api.instagram.com/v1/users/#{params.user_id}/relationship"
		object = {access_token: @access_token, action: params.action}
		$["post"](relationship_url, object).success (data) ->
			console.log("Request sent #{data} ...")
		return


	instagramAPI::login = ->
		redirect = 'https://nfcimppfkbpdohcgpdifipajpbahncnc.chromiumapp.org/provider_cb'
		login_url = "https://api.instagram.com/oauth/authorize/?client_id=#{USER.clientId}&redirect_uri=#{redirect}&response_type=token&scope=likes+comments+relationships"

		chrome.identity.launchWebAuthFlow({'url': login_url, 'interactive': true}, (responseUrl) ->
			console.log(responseUrl)
			window.localStorage.setItem('in_user', JSON.stringify({access_token: responseUrl.split('#access_token=')[1]}))
			$location.path('/instagram/feed')
		)
		return

	instagramAPI::nextPage = ->
		return  if @busy
		$('#instagram').parent().append(@loading)
		@busy = true
		@page = 2 unless @page
		$http.get(@next_url).success (data) =>
			@next_url = data.pagination.next_url
			@photos = @photos.concat(data.data)
			@page = @page + 1
			@busy = false
			$('.loading-heart-container').remove()
			return

		return

	instagramAPI
