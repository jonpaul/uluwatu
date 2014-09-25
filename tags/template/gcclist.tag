
<form class="form-horizontal" role="document"><!-- role: 'document' - non-editable "form" -->

    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclclusterName">Name</label>

        <div class="col-sm-9">
            <p id="gcclclusterName" class="form-control-static">{{template.name}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <!-- .form-group -->
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclclusterDesc">Description</label>

        <div class="col-sm-9">
            <p id="gcclclusterDesc" class="form-control-static">{{template.description}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclgccZone">Zone</label>

        <div class="col-sm-9">
            <p id="gcclgccZone" class="form-control-static">{{template.parameters.gccZone}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <!-- .form-group -->
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclgccImageType">Image type</label>

        <div class="col-sm-9">
            <p id="gcclgccImageType" class="form-control-static">{{template.parameters.gccImageType}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <!-- .form-group -->
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclgccInstanceType">Instance Type</label>

        <div class="col-sm-9">
            <p id="gcclgccInstanceType" class="form-control-static">{{template.parameters.gccInstanceType}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
  
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gccvolumecount">Attached volumes per instance</label>

        <div class="col-sm-9">
            <p id="gccvolumecount" class="form-control-static">{{template.volumeCount}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gccvolumesize">Volume size (GB)</label>

        <div class="col-sm-9">
            <p id="gccvolumesize" class="form-control-static">{{template.volumeSize}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <div class="form-group" ng-if="template.parameters.moreContainerOnOneHost">
        <label class="col-sm-3 control-label" for="gcccontainercount">Count of Container per instance</label>

        <div class="col-sm-9">
            <p id="gcccontainercount" class="form-control-static">{{template.parameters.containerCount}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>

</form>