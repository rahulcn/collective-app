// Generated by CoffeeScript 2.0.0-beta8
ApplicationController.controller('InstagramController', function ($scope, $location, instagramAPI, $routeParams, $timeout) {
  $scope.service = new instagramAPI($routeParams);
  switch ($routeParams.filter) {
  case 'follows':
    $scope.service.fetchUsers();
    break;
  case 'followed-by':
    $scope.service.fetchUsers();
    break;
  default:
    $scope.service.firstPage();
  }
});
