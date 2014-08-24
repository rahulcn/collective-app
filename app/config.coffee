window.Application = angular.module('CollectiveApp', [
	'ngRoute',
	'ui.router',
	'CollectiveApp.directives',
	'CollectiveApp.services',
	'CollectiveApp.controllers'
])
window.ApplicationDirective = angular.module('CollectiveApp.directives', [])
window.ApplicationService = angular.module('CollectiveApp.services', [])
window.ApplicationController = angular.module('CollectiveApp.controllers', [])
