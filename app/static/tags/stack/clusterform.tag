<div id="cluster-form-panel" class="col-sm-11 col-md-9 col-lg-9">
    <div class="panel panel-default">
        <div class="panel-heading panel-heading-nav">
            <a href="" id="create-cluster-back-btn" class="btn btn-info btn-fa-2x" role="button"><i class="fa fa-angle-left fa-2x fa-fw-forced"></i></a>
            <h4>Create cluster</h4>
        </div>
        <div id="create-cluster-panel-collapse" class="panel panel-default">
            <div class="panel-body">
                <form class="form-horizontal" role="form" name="clusterCreationForm">
                    <div class="form-group" ng-class="{ 'has-error': clusterCreationForm.cl_clusterName.$dirty && clusterCreationForm.cl_clusterName.$invalid }">
                        <label class="col-sm-3 control-label" for="cl_clusterName">Cluster name</label>
                        <div class="col-sm-9">
                            <input type="text" name="cl_clusterName" class="form-control" id="cl_clusterName" name="cl_clusterName" placeholder="min. 5 max. 20 char" ng-model="cluster.name"  ng-pattern="/^[a-zA-Z][-a-zA-Z0-9]*$/" ng-minlength="5" ng-maxlength="20" required>
                            <div class="help-block"
                                 ng-show="clusterCreationForm.cl_clusterName.$dirty && clusterCreationForm.cl_clusterName.$invalid"><i class="fa fa-warning"></i> {{error_msg.cluster_name_invalid}}
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{ 'has-error': clusterCreationForm.cl_clusterSize.$dirty && clusterCreationForm.cl_clusterSize.$invalid }">
                        <label class="col-sm-3 control-label" for="cl_clusterSize">Cluster size</label>
                        <div class="col-sm-9">
                            <input type="number" name="cl_clusterSize" class="form-control" ng-model="cluster.nodeCount" id="cl_clusterSize" min="1"   max="99" placeholder="1 - 99" required>
                            <div class="help-block"
                                 ng-show="clusterCreationForm.cl_clusterSize.$dirty && clusterCreationForm.cl_clusterSize.$invalid"><i class="fa fa-warning"></i>
                                {{error_msg.cluster_size_invalid}}
                            </div>
                        </div>
                    </div>

                    <hr class="form-group-separator">

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectHadoopDistro">select Hadoop distro <i class="fa fa-check fa-fw hidden"></i></label>
                        <div class="col-sm-9 ">
                            <div class="btn-segmented-control" id="selectHadoopDistro" data-next="#selectRuntime">
                                <div class="btn-group btn-group-justified">
                                    <a  class="btn btn-default" role="button" ng-click="showHdpServiceList()">Hortonworks HDP</a>
                                    <a  class="btn btn-default" role="button" ng-click="showCdhServiceList()">Cloudera CDH</a>
                                    <a  class="btn btn-default" role="button" ng-click="showAhServiceList()">Apache Hadoop</a>
                                </div>
                            </div><!-- .btn-segmented-control -->
                        </div><!-- .col-sm-9 -->
                    </div><!-- .form-group -->

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectRuntime">select runtime <i class="fa fa-check fa-fw hidden"></i></label>
                        <div class="col-sm-offset-1 col-sm-8 collapse" id="selectRuntime">
                            <div class="btn-segmented-control" data-next="#selectServiceBlock">
                                <div class="btn-group btn-group-sm btn-group-justified">
                                    <a  class="btn btn-default" role="button" ng-click="showMr2ServiceListShow()">MR2</a>
                                    <a  class="btn btn-default" role="button" ng-click="showTezServiceListShow()" ng-show="!cdhServiceListShow">Tez</a>
                                    <a  class="btn btn-default" role="button" ng-click="showSparkServiceListShow()">Spark</a>
                                </div>
                            </div><!-- .btn-segmented-control -->
                        </div><!-- .col-sm-9 -->
                    </div><!-- .form-group -->


                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectService">select services <i class="fa fa-check fa-fw hidden"></i></label>

                        <div class="col-sm-offset-2 col-sm-7 collapse" id="selectServiceBlock">

                            <div class="row"><div class="col-sm-12">

                                <ul class="nav nav-pills nav-pills-sm nav-justified" role="tablist">
                                    <li class="active"><a  role="tab" data-toggle="tab" ng-click="showManualTab()">manually</a></li>
                                    <li><a  role="tab" data-toggle="tab" ng-click="showBlueprintTab()">from blueprint</a></li>
                                </ul>

                            </div></div>


                            <div class="tab-content">

                                <div class="tab-pane  fade in" id="servicePane" ng-show="manualSelectionPaneShow" ng-class="{ 'active': manualSelectionPaneShow }"><!-- service buttons -->

                                    <div class="btn-segmented-control multiselect" id="selectService">
                                        <div class="btn-group btn-group-sm btn-group-justified">
                                            <a class="btn btn-info btn-mandatory disabled" role="button">HDFS</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">YARN</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">MAPREDUCE2</a>
                                        </div>
                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="sparkServiceListShow">
                                            <a class="btn btn-info btn-mandatory disabled" role="button">ZOOKEEPER</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">SPARK</a>
                                            <a class="btn" ng-hide></a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="tezServiceListShow">
                                            <a class="btn btn-default" role="button">HIVE</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">ZOOKEEPER</a>
                                            <a class="btn" ng-hide></a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="mr2ServiceListShow && ahServiceListShow">
                                            <a class="btn btn-info btn-mandatory disabled" role="button">ZOOKEEPER</a>
                                            <a class="btn btn-default" role="button">HIVE</a>
                                            <a class="btn btn-default" role="button">HBASE</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="cdhServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">HBASE</a>
                                            <a class="btn btn-default" role="button">OOZIE</a>
                                            <a class="btn btn-default" role="button">HUE</a>
                                        </div>
                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="cdhServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">HIVE</a>
                                            <a class="btn btn-default" role="button">FLUME</a>
                                            <a class="btn btn-default" role="button">IMPALA</a>
                                        </div>
                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="cdhServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">SQOOP</a>
                                            <a class="btn btn-default" role="button">SEARCH</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">ZOOKEEPER</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="hdpServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">HCATALOG</a>
                                            <a class="btn btn-default" role="button">WEBCATALOG</a>
                                            <a class="btn btn-default" role="button">WEBHCAT</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="hdpServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">GANGLIA</a>
                                            <a class="btn btn-default" role="button">HBASE</a>
                                            <a class="btn btn-default" role="button">HIVE</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="hdpServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">NAGIOS</a>
                                            <a class="btn btn-default" role="button">OOZIE</a>
                                            <a class="btn btn-default" role="button">PIG</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="hdpServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">SQOOP</a>
                                            <a class="btn btn-default" role="button">STORM</a>
                                            <a class="btn btn-default" role="button">TEZ</a>
                                        </div>

                                        <div class="btn-group btn-group-sm btn-group-justified" ng-show="hdpServiceListShow && mr2ServiceListShow"><!-- 3 buttons per row -->
                                            <a class="btn btn-default" role="button">FALCON</a>
                                            <a class="btn btn-info btn-mandatory disabled" role="button">ZOOKEEPER</a>
                                            <a class="btn" ng-hide></a>
                                        </div>

                                    </div><!-- .btn-segmented-control -->

                                </div><!-- .tab-pane -->

                                <div class="tab-pane fade in" id="blueprintPane" ng-show="blueprintSelectionPaneShow" ng-class="{ 'active': blueprintSelectionPaneShow }"><!-- blueprint select -->
                                    <select class="form-control" id="selectBlueprint" ng-model="cluster.blueprintId"  required >
                                        <option ng-repeat="blueprint in $root.blueprints | orderBy:'name'" data-value="{{blueprint.id}}" value="{{blueprint.id}}" id="{{blueprint.id}}">{{blueprint.name}}</option>
                                    </select>

                                </div><!-- .tab-pane -->
                            </div><!-- .tab-content -->

                        </div><!-- .col-sm-9 -->

                    </div><!-- .form-group -->

                    <hr class="form-group-separator">

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectCloud">select cloud provider <i class="fa fa-check fa-fw hidden"></i></label>
                        <div class="col-sm-9">
                            <div class="btn-segmented-control" id="selectCloud" data-next=".selectCredentialNTemplate">
                                <div class="btn-group btn-group-justified"><!-- 3 buttons per row -->
                                    <a class="btn btn-default" role="button" ng-click="changeActiveCloudPlatform('AWS')">AWS</a>
                                    <a class="btn btn-default" role="button" ng-click="changeActiveCloudPlatform('AZURE')">Azure</a>
                                </div>
                                <div class="btn-group btn-group-justified"><!-- 3 buttons per row -->
                                    <a class="btn btn-default" role="button" ng-click="changeActiveCloudPlatform('GCC')">Google Cloud</a>
                                    <a class="btn btn-default" role="button" disabled ng-click="changeActiveCloudPlatform('DIGITAL_OCEAN')">Digital Ocean</a>
                                </div>
                            </div><!-- .btn-segmented-control -->
                        </div><!-- .col-sm-9 -->
                    </div><!-- .form-group -->

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectTemplate">Template</label>
                        <div class="col-sm-9">
                            <select class="form-control" id="selectTemplate" ng-model="cluster.templateId" required >
                                <option ng-repeat="template in $root.templates | orderBy:'name'" data-value="{{template.id}}" value="{{template.id}}" id="{{template.id}}" ng-if="template.cloudPlatform == activecloudPlatform">{{template.name}}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="selectCredential">Credential</label>
                        <div class="col-sm-9">
                            <select class="form-control" id="selectCredential" ng-model="cluster.credentialId" required >
                                <option ng-repeat="credential in $root.credentials | orderBy:'name'" data-value="{{credential.id}}" value="{{credential.id}}" id="{{credential.id}}" ng-if="credential.cloudPlatform == activecloudPlatform">{{credential.name}}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label class="col-sm-3 control-label" for="emailneeded">Email notification when cluster is provisioned</label>
                        <div class="col-sm-9">
                            <input type="checkbox" id="emailneeded" ng-model="cluster.email" name="emailneeded">
                        </div>
                    </div>
                    <div class="row btn-row">
                        <div class="col-sm-9 col-sm-offset-3">
                            <a href="" id="createCluster" class="btn btn-success btn-block" ng-disabled="clusterCreationForm.$invalid" role="button" ng-click="createCluster()"><i class="fa fa-plus fa-fw"></i>create and start cluster</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
