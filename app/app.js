// Generated by CoffeeScript 2.0.0-beta8
void function () {
  var YTMenu;
  Application.config([
    '$routeProvider',
    '$compileProvider',
    function ($routeProvider, $compileProvider) {
      $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|chrome-extension):/);
      return $routeProvider.when('/500px/:category', {
        templateUrl: 'templates/fhpx_view.html',
        controller: '500pxController'
      }).when('/dribble/:category', {
        templateUrl: 'templates/dribble_view.html',
        controller: 'DribbleController'
      }).otherwise({ redirectTo: '/500px/popular' });
    }
  ]);
  YTMenu = function () {
    var init;
    init = function () {
      [].slice.call(document.querySelectorAll('.dr-menu')).forEach(function (el, i) {
        var icon, open, trigger;
        trigger = el.querySelector('div.dr-trigger');
        icon = trigger.querySelector('i.fa-bars');
        open = false;
        trigger.addEventListener('click', function (event) {
          if (!open) {
            el.className += ' dr-menu-open';
            open = true;
          }
        }, false);
        icon.addEventListener('click', function (event) {
          if (open) {
            event.stopPropagation();
            open = false;
            el.className = el.className.replace(/\bdr-menu-open\b/, '');
            return false;
          }
        }, false);
      });
    };
    init();
  }();
  $(function () {
    return $('.sidebar-trigger').on('click', function () {
      var sidebar, view;
      $(this).toggleClass('sidebar-trigger-close');
      sidebar = $("div[data-col='sidebar']");
      view = $("div[data-col='view']");
      sidebar.toggleClass('sidebar-close sidebar-top');
      $('#menu', sidebar).toggle();
      $('#bookmark', sidebar).toggle();
      return setTimeout(function () {
        return sidebar.toggleClass('bookmark-bg sidebar-close');
      }, 500);
    });
  });
}.call(this);
