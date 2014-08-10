ApplicationController.controller "SettingsController", ($scope) ->
	$scope.template = 'templates/settings_view.html'

	$scope.showTab = ($event) ->
		tab = $($event.target)
		$('.nav-tabs li').removeClass('active')
		$('.tab-pane').removeClass('active')
		tab.parent().addClass('active')
		$(tab.data('pane')).addClass('active')
		return

	return