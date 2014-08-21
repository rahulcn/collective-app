// Generated by CoffeeScript 2.0.0-beta8
ApplicationService.factory('instagramAPI', function ($http) {
  var instagramAPI, USER;
  USER = {
    accessId: '255614267',
    accessToken: '255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063'
  };
  instagramAPI = function (options) {
    var filter;
    this.photos = [];
    this.profile = [];
    this.loading = $('<div class="loading"><div></div><div></div><div></div><div></div></div>');
    this.busy = false;
    if (options.filter === 'feed') {
      filter = options.filter;
    } else {
      filter = 'media/' + options.filter;
    }
    this.options = '' + filter + '?count=30&access_token=' + USER.accessToken;
  };
  instagramAPI.prototype.firstPage = function () {
    var profile_url, url;
    $('#grids').parent().append(this.loading);
    profile_url = 'https://api.instagram.com/v1/users/255614267?access_token=255614267.fadd55a.739ffff76085430bafd6ec58e9cfa063';
    url = 'https://api.instagram.com/v1/users/self/' + this.options;
    $http.get(profile_url).success(function (this$) {
      return function (data) {
        this$.profile = data.data;
        return $http.get(url).success(function (this$1) {
          return function (data) {
            this$1.next_url = data.pagination.next_url;
            this$1.photos = this$1.photos.concat(data.data);
            window.localStorage.setItem('in_photos', JSON.stringify(this$1.photos));
            $('.loading').remove();
          };
        }(this$));
      };
    }(this));
  };
  instagramAPI.prototype.nextPage = function () {
    if (this.busy)
      return;
    $('#grids').parent().append(this.loading);
    this.busy = true;
    if (!this.page)
      this.page = 2;
    $http.get(this.next_url).success(function (this$) {
      return function (data) {
        this$.next_url = data.pagination.next_url;
        this$.photos = this$.photos.concat(data.data);
        this$.page = this$.page + 1;
        this$.busy = false;
        $('.loading').remove();
      };
    }(this));
  };
  return instagramAPI;
});
