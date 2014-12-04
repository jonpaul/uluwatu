<div id="active-cluster-panel" class="col-sm-11 col-md-11 col-lg-11">
    <div class="panel panel-default">
        <div class="panel-heading panel-heading-nav">
            <a href="" id="cluster-details-back-btn" class="btn btn-info btn-fa-2x" role="button"><i class="fa fa-angle-left fa-2x fa-fw-forced"></i></a>
            <h4>{{activeCluster.name}}</h4>
        </div>
        <div id="cluster-details-panel-collapse">
            <div class="panel-body">
                <ul class="nav nav-pills nav-justified" role="tablist">
                  <li class="active"><a ng-click="showDetails()" role="tab" data-toggle="tab">details</a></li>
                  <li><a role="tab" ng-click="showPeriscope()" role="tab" data-toggle="tab">autoscaling SLA policies</a></li>
                </ul>
                <div class="tab-content">
                    <section id="cluster-details-pane" ng-class="{ 'active': detailsShow }" ng-show="detailsShow" class="tab-pane fade in">
                        <p class="text-right">
                            <a href="" class="btn btn-success" role="button" ng-show="activeCluster.cloudPlatform != 'GCC' && activeCluster.status == 'STOPPED'" data-toggle="modal" data-target="#modal-start-cluster">
                                <i class="fa fa-play fa-fw"></i><span> start</span>
                            </a>
                            <a href="" class="btn btn-warning" role="button" ng-show="activeCluster.cloudPlatform != 'GCC' && activeCluster.status == 'AVAILABLE'" data-toggle="modal" data-target="#modal-stop-cluster">
                                <i class="fa fa-pause fa-fw"></i><span> stop</span>
                            </a>
                            <a href="" id="terminate-btn" class="btn btn-danger" role="button" data-toggle="modal" data-target="#modal-terminate">
                                <i class="fa fa-times fa-fw"></i><span> terminate</span>
                            </a>
                        </p>
                        <form class="form-horizontal" role="document"><!-- role: 'document' - non-editable "form" -->
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="sl_ambariServerIp">Ambari server adress</label>
                                <div class="col-sm-9">
                                    <p id="sl_ambariServerIp" class="form-control-static">
                                        <div ng-if="activeCluster.ambariServerIp != null">
                                            <a ng-show="activeCluster.ambariServerIp != null" target="_blank" href="http://{{activeCluster.ambariServerIp}}:8080">http://{{activeCluster.ambariServerIp}}:8080</a>
                                        </div>
                                        <div ng-if="activeCluster.ambariServerIp == null">
                                            <a ng-show="activeCluster.ambariServerIp == null" target="_blank" href="">Not Available</a>
                                        </div>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="sl_cloudPlatform">Platform</label>
                                <div class="col-sm-9">
                                    <p id="sl_cloudPlatform" class="form-control-static">{{activeCluster.cloudPlatform}}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="sl_nodeCount">Number of nodes</label>
                                <div class="col-sm-9">
                                    <p id="sl_nodeCount" class="form-control-static">{{activeCluster.nodeCount}}</p>
                                </div>
                            </div>
                            <div class="form-group" ng-if="activeCluster.cluster.statusReason === null && (activeCluster.statusReason != null && activeCluster.statusReason != '')">
                                <label class="col-sm-3 control-label" for="sl_cloudStatus">Cluster status</label>
                                <div class="col-sm-9">
                                    <p id="sl_cloudStatus" class="form-control-static">{{activeCluster.statusReason}}</p>
                                </div>
                                <div class="col-sm-9" ng-if="activeCluster.cluster.statusReason != null && activeCluster.cluster.statusReason != ''">
                                    <p id="sl_cloudStatus" class="form-control-static">{{activeCluster.cluster.statusReason}}</p>
                                </div>
                            </div>
                            <div class="form-group" ng-if="activeCluster.cluster.statusReason != null && activeCluster.cluster.statusReason != ''">
                                <label class="col-sm-3 control-label" for="sl_cloudStatus">Cluster status</label>
                                <div class="col-sm-9">
                                    <p id="sl_cloudStatus" class="form-control-static">{{activeCluster.cluster.statusReason}}2</p>
                                </div>
                            </div>
                        </form>

                        <div class="panel panel-default panel-cluster-history">
                            <div class="panel-heading">
                                <h5><a data-toggle="collapse" data-target="#cluster-history-collapse01"><i class="fa fa-clock-o fa-fw"></i>Event history</a></h5>
                            </div>

                            <div id="cluster-history-collapse01" class="panel-collapse collapse" style="height: auto;">

                                <div class="panel-body">

                                    <form class="form-horizontal" role="document">

                                        <div class="form-group">
                                            <div class="col-sm-12">
												<pre class="form-control-static event-history">
<span ng-repeat="actual in $root.events |filter:logFilterFunction|orderBy:eventTimestampAsFloat"><span class="{{$root.config.EVENT_CLASS[actual .eventType]}}" >{{actual.customTimeStamp}} {{actual.stackName}} - {{$root.config.EVENT_TYPE[actual .eventType]}}: {{actual.eventMessage}}</span><br/></span>
                                                </pre>
                                            </div><!-- .col-sm-12  -->
                                        </div><!-- .form-group -->

                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5><a href="" data-toggle="collapse" data-target="#panel-collapse0002"><i class="fa fa-align-justify fa-fw"></i>Cloud stack description: {{activeCluster.name}}</a></h5>
                            </div>
                            <div id="panel-collapse0002" class="panel-collapse collapse">
                                <div class="panel-body" ng-switch on="activeCluster.cloudPlatform">
                                    <div ng-switch-when="GCC">
                                        <table class="table table-report table-sortable-cols table-with-pagination ">
                                            <thead>
                                            <tr>
                                                <th>name</th>
                                                <th>status</th>
                                                <th>private IP</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="instance in activeCluster.description.resources| filter:gccFilterFunction">
                                                <td>{{instance.name}}</td>
                                                <td>{{instance.status}}</td>
                                                <td>{{instance.networkInterfaces[0].networkIP}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div ng-switch-when="AZURE">
                                        <table class="table table-report table-sortable-cols table-with-pagination ">
                                            <thead>
                                            <tr>
                                                <th>name</th>
                                                <th>status</th>
                                                <th>private IP</th>
                                                <th>public IP</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="instance in activeCluster.description.resources| filter:azureFilterFunction">
                                                <td>{{instance.Deployment.Name}}</td>
                                                <td>{{instance.Deployment.Status}}</td>
                                                <td>{{instance.Deployment.RoleInstanceList.RoleInstance.IpAddress}}</td>
                                                <td>{{instance.Deployment.VirtualIPs.VirtualIP.Address}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div ng-switch-when="AWS">
                                        <table class="table table-report table-sortable-cols table-with-pagination ">
                                            <thead>
                                            <tr>
                                                <th>name</th>
                                                <th>status</th>
                                                <th>private IP</th>
                                                <th>public IP</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="instance in activeCluster.description.instances.reservations[0].instances">
                                                <td>{{instance.instanceId}}</td>
                                                <td>{{instance.state.name}}</td>
                                                <td>{{instance.privateIpAddress}}</td>
                                                <td>{{instance.publicIpAddress}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div ng-switch-default><pre id="sl_description" class="form-control-static">{{activeCluster.description | json}}</pre></div>

                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5><a href="" data-toggle="collapse" data-target='#panel-collapse01'><i class="fa fa-file-o fa-fw"></i>Template: {{activeClusterTemplate.name}}</a></h5>
                            </div>
                            <div id="panel-collapse01" class="panel-collapse collapse">
                                <div class="panel-body" ng-if="activeClusterTemplate.cloudPlatform == 'AWS' ">
                                    <div ng-include="'tags/template/awslist.tag'" ng-repeat="template in [activeClusterTemplate]"></div>
                                </div>
                                <div class="panel-body" ng-if="activeClusterTemplate.cloudPlatform == 'AZURE' ">
                                    <div ng-include="'tags/template/azurelist.tag'" ng-repeat="template in [activeClusterTemplate]"></div>
                                </div>
                                <div class="panel-body" ng-if="activeClusterTemplate.cloudPlatform == 'GCC' ">
                                    <div ng-include="'tags/template/gcclist.tag'" ng-repeat="template in [activeClusterTemplate]"></div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5><a href="" data-toggle="collapse" data-target="#panel-collapse02"><i class="fa fa-th fa-fw"></i>Blueprint: {{activeClusterBlueprint.name}}</a></h5>
                            </div>
                            <div id="panel-collapse02" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div class="row" ng-repeat="blueprint in [activeClusterBlueprint]" ng-include="'tags/blueprint/bplist.tag'" ></div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5><a href="" data-toggle="collapse" data-target="#panel-collapse001"><i class="fa fa-tag fa-fw"></i>Credential: {{activeClusterCredential.name}}</a></h5>
                            </div>
                            <div id="panel-collapse001" class="panel-collapse collapse">
                                <div class="panel-body" ng-if="activeClusterCredential.cloudPlatform == 'AWS' ">
                                    <div ng-include="'tags/credential/awslist.tag'" ng-repeat="credential in [activeClusterCredential]"></div>
                                </div>
                                <div class="panel-body" ng-if="activeClusterCredential.cloudPlatform == 'AZURE' ">
                                    <div ng-include="'tags/credential/azurelist.tag'" ng-repeat="credential in [activeClusterCredential]"></div>
                                </div>
                                <div class="panel-body" ng-if="activeClusterCredential.cloudPlatform == 'GCC' ">
                                    <div ng-include="'tags/credential/gcclist.tag'" ng-repeat="credential in [activeClusterCredential]"></div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section id="periscope-pane" ng-class="{ 'active': periscopeShow }" ng-show="periscopeShow" class="tab-pane fade in">
                        <div ng-include="'tags/stack/periscope.tag'"></div>
                    </section>
                    <section id="metrics-pane" ng-class="{ 'active': metricsShow }" ng-show="metricsShow" targe class="tab-pane fade in">
                    </section>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-terminate" tabindex="-1" role="dialog" aria-labelledby="modal01-title" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- .modal-header -->
                <div class="modal-body">
                    <p>Terminate cluster <strong>{{activeCluster.name}}</strong> and its stack?</p>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">cancel</button>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-danger" data-dismiss="modal" id="terminateStackBtn" ng-click="deleteCluster(activeCluster)"><i class="fa fa-times fa-fw"></i>terminate</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-stop-cluster" tabindex="-1" role="dialog" aria-labelledby="modal01-title" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- .modal-header -->
                <div class="modal-body">
                    <p>Stop cluster <strong>{{activeCluster.name}}</strong> and its stack?</p>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">cancel</button>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-warning" data-dismiss="modal" id="stackStackBtn" ng-click="stopCluster(activeCluster)"><i class="fa fa-pause fa-fw"></i>stop</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-start-cluster" tabindex="-1" role="dialog" aria-labelledby="modal01-title" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- .modal-header -->
                <div class="modal-body">
                    <p>Start cluster <strong>{{activeCluster.name}}</strong> and its stack?</p>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">cancel</button>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-block btn-success" data-dismiss="modal" id="stackStackBtn" ng-click="startCluster(activeCluster)"><i class="fa fa-play fa-fw"></i>start</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
