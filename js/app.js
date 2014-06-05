'use strict';

/* App Module */

var cloudbreakApp = angular.module('cloudbreakApp', ['ngRoute', 'cloudbreakControllers', 'cloudbreakServices']);

cloudbreakApp.config([ '$routeProvider', function($routeProvider) {
    $routeProvider.when('/', {
        controller: 'cloudbreakController'
    }) .otherwise({
        redirectTo : '/'
    });
 /*       .when('/console', {
        templateUrl : 'partials/console.html',
        controller: 'consoleController'
    })*/

} ]);