ApplicationController.controller "BookmarkController", ($scope) ->
	$scope.template =
		name: 'bookmark_view'
		path: 'templates/bookmark_view.html'
	console.log 'bookmarks..!'