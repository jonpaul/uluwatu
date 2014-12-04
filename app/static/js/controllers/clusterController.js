'use strict';

var log = log4javascript.getLogger("clusterController-logger");
var $jq = jQuery.noConflict();

angular.module('uluwatuControllers').controller('clusterController', ['$scope', '$rootScope', '$filter', 'UluwatuCluster', 'GlobalStack', 'Cluster', '$interval', 'UserEvents',
    function ($scope, $rootScope, $filter, UluwatuCluster, GlobalStack, Cluster, $interval, UserEvents) {

        $rootScope.ledStyles = {
            "REQUESTED": "state2-run-blink",
            "CREATE_IN_PROGRESS": "state2-run-blink",
            "UPDATE_IN_PROGRESS": "state2-run-blink",
            "AVAILABLE": "state5-run",
            "DELETE_IN_PROGRESS": "state0-stop-blink",
            "DELETE_COMPLETED": "state3-stop",
            "STOPPED": "state4-ready",
            "START_REQUESTED": "state1-ready-blink",
            "START_IN_PROGRESS": "state1-ready-blink",
            "STOP_REQUESTED": "state1-ready-blink",
            "STOP_IN_PROGRESS": "state1-ready-blink",
            "CREATE_FAILED": "state3-stop",
            "START_FAILED": "state3-stop",
            "DELETE_FAILED": "state3-stop",
            "UPDATE_FAILED": "state3-stop",
            "STOP_FAILED": "state3-stop"
        }

        $rootScope.buttonStyles = {
            "REQUESTED": "fa-pause",
            "CREATE_IN_PROGRESS": "fa-pause",
            "UPDATE_IN_PROGRESS": "fa-pause",
            "AVAILABLE": "fa-stop",
            "DELETE_IN_PROGRESS": "fa-pause",
            "DELETE_COMPLETED": "fa-stop",
            "STOPPED": "fa-play",
            "START_REQUESTED": "fa-refresh",
            "START_IN_PROGRESS": "fa-refresh",
            "STOP_REQUESTED": "fa-refresh",
            "STOP_IN_PROGRESS": "fa-refresh",
            "CREATE_FAILED": "fa-play",
            "START_FAILED": "fa-play",
            "DELETE_FAILED": "fa-play",
            "UPDATE_FAILED": "fa-play",
            "STOP_FAILED": "fa-play"
        }

        $rootScope.activeCluster = {};

        $scope.detailsShow = true;
        $scope.periscopeShow = false;
        $scope.metricsShow = false;
        getUluwatuClusters();
        initCluster();

        $scope.createCluster = function () {
            var blueprint = $filter('filter')($rootScope.blueprints, {id: $scope.cluster.blueprintId}, true)[0];

            if (blueprint.hostGroupCount > $scope.cluster.nodeCount) {
                $scope.modifyStatusMessage($rootScope.error_msg.hostgroup_invalid_node_count);
                $scope.modifyStatusClass("has-error");
                return;
            }
            if (blueprint.hostGroupCount === 1 && $scope.cluster.nodeCount != 1) {
                $scope.modifyStatusMessage($rootScope.error_msg.hostgroup_single_invalid);
                $scope.modifyStatusClass("has-error");
                return;
            }

            $scope.cluster.credentialId = $rootScope.activeCredential.id;
            UluwatuCluster.save($scope.cluster, function (result) {
                $rootScope.clusters.push(result);
                initCluster();

                //$scope.modifyStatusMessage($rootScope.error_msg.cluster_success1 + result.name + $rootScope.error_msg.cluster_success2);
                //$scope.modifyStatusClass("has-success");

                $jq('.carousel').carousel(0);
                // enable toolbar buttons
                $jq('#toggle-cluster-block-btn').removeClass('disabled');
                $jq('#sort-clusters-btn').removeClass('disabled');
                $jq('#create-cluster-btn').removeClass('disabled');
                $jq("#notification-n-filtering").prop("disabled", false);
                $scope.clusterCreationForm.$setPristine();
            }, function(failure) {
                $scope.modifyStatusMessage($rootScope.error_msg.cluster_failed + ": " + failure.data.message);
                $scope.modifyStatusClass("has-error");
            });
        }

        $scope.deleteCluster = function (cluster) {
            UluwatuCluster.delete(cluster, function (result) {
                var actCluster = $filter('filter')($rootScope.clusters, { id: cluster.id }, true)[0];
                actCluster.status = "DELETE_IN_PROGRESS";
                $scope.modifyStatusMessage($rootScope.error_msg.cluster_delete_success1 + cluster.id + $rootScope.error_msg.cluster_delete_success2);
                $scope.modifyStatusClass("has-success");
            }, function (failure){
                $scope.modifyStatusMessage($rootScope.error_msg.cluster_delete_failed + ": " + failure.data.message);
                $scope.modifyStatusClass("has-error");
            });
        }

        $scope.changeActiveCluster = function (clusterId) {
            $rootScope.activeCluster = $filter('filter')($rootScope.clusters, { id: clusterId })[0];
            $rootScope.activeClusterBlueprint = $filter('filter')($rootScope.blueprints, { id: $rootScope.activeCluster.blueprintId})[0];
            $rootScope.activeClusterTemplate = $filter('filter')($rootScope.templates, {id: $rootScope.activeCluster.templateId}, true)[0];
            $rootScope.activeClusterCredential = $filter('filter')($rootScope.credentials, {id: $rootScope.activeCluster.credentialId}, true)[0];
            $rootScope.activeCluster.cloudPlatform =  $rootScope.activeClusterCredential.cloudPlatform;
            GlobalStack.get({ id: clusterId }, function(success) {
                    $rootScope.activeCluster.description = success.description;
                }
            );
        }

        $rootScope.events = [];

        $scope.loadEvents = function () {
            $rootScope.events = UserEvents.query(function(success) {
                angular.forEach(success, function(item) {
                    item.customTimeStamp =  new Date(item.eventTimestamp).toLocaleDateString() + " " + new Date(item.eventTimestamp).toLocaleTimeString();
                });
            });
        }

        $scope.loadEvents();

        $scope.stopCluster = function (activeCluster) {
            var newStatus = {"status":"STOPPED"};
            Cluster.update({id: activeCluster.id}, newStatus, function(success){

                GlobalStack.update({id: activeCluster.id}, newStatus, function(result){
                    activeCluster.status = "STOP_REQUESTED";
                }, function(error) {
                  $scope.modifyStatusMessage($rootScope.error_msg.cluster_stop_failed + ": " + error.data.message);
                  $scope.modifyStatusClass("has-error");
                });

            }, function(error) {
              $scope.modifyStatusMessage($rootScope.error_msg.cluster_stop_failed + ": " + error.data.message);
              $scope.modifyStatusClass("has-error");
            });
        }

        $scope.startCluster = function (activeCluster) {
            var newStatus = {"status":"STARTED"};
            GlobalStack.update({id: activeCluster.id}, newStatus, function(result){

                Cluster.update({id: activeCluster.id}, newStatus, function(success){
                    activeCluster.status = "START_REQUESTED";
                }, function(error) {
                  $scope.modifyStatusMessage($rootScope.error_msg.cluster_start_failed + ": " + error.data.message);
                  $scope.modifyStatusClass("has-error");
                });

            }, function(error) {
              $scope.modifyStatusMessage($rootScope.error_msg.cluster_start_failed + ": " + error.data.message);
              $scope.modifyStatusClass("has-error");
            });
        }

        $scope.requestStatusChange = function(cluster) {
            if(cluster.status == "STOPPED") {
                $scope.startCluster(cluster);
            } else if(cluster.status == "AVAILABLE") {
                $scope.stopCluster(cluster);
            }
        }

        function getUluwatuClusters(){
          UluwatuCluster.query(function (clusters) {
              $rootScope.clusters = clusters;
              $scope.$parent.orderClusters();
          });
        }

        function initCluster(){
            $scope.cluster = {
                password: "admin",
                userName: "admin"
            };
        }

        $scope.showDetails = function () {
            $scope.detailsShow = true;
            $scope.periscopeShow = false;
            $scope.metricsShow = false;
        }

        $scope.showPeriscope = function () {
            $scope.detailsShow = false;
            $scope.periscopeShow = true;
            $scope.metricsShow = false;
        }

        $scope.showMetrics = function () {
            $scope.detailsShow = false;
            $scope.periscopeShow = false;
            $scope.metricsShow = true;
        }


        $scope.logFilterFunction = function(element) {
            try {
                if (element.stackId === $rootScope.activeCluster.id) {
                    return (!element.eventType.match('BILLING_STARTED') && !element.eventType.match('BILLING_STOPPED') && !element.eventType.match('BILLING_CHANGED')) ? true : false;
                } else {
                    return false;
                }
            } catch (err) {
                return false;
            }
        }

        $scope.gccFilterFunction = function(element) {
            try {
                return element.kind.match("compute#instance") ? true : false;
            } catch (err) {
                return false;
            }
        }

        $scope.azureFilterFunction = function(element) {
            try {
                return element.Deployment === undefined ? false : true;
            } catch (err) {
                return false;
            }
        }

    }]);
