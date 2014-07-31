// Generated by CoffeeScript 2.0.0-beta8
ApplicationController.controller('500pxController', function ($scope, $location, fhpxAPI, $routeParams) {
  var path;
  path = $location.path().split('/')[2];
  $scope.setActive([
    'fhpx',
    path
  ]);
  $scope.service = new fhpxAPI({ category: path });
  if (!window.localStorage.getItem('ca_photos')) {
    $scope.service.firstPage();
  } else {
    $scope.service.photos = JSON.parse(window.localStorage.getItem('ca_photos'));
  }
});
