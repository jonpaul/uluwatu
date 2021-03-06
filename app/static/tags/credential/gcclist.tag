<form class="form-horizontal" role="document"><!-- role: 'document' - non-editable "form" -->

    <div class="form-group">
        <label class="col-sm-3 control-label" for="gccclname">Name</label>

        <div class="col-sm-9">
            <p id="gccclname" class="form-control-static">{{credential.name}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>

    <div class="form-group" ng-show="credential.description">
        <label class="col-sm-3 control-label" for="gcccldescriptionfield">Description</label>

        <div class="col-sm-9">
            <p id="gcccldescriptionfield" class="form-control-static">{{credential.description}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>

    <div class="form-group">
        <label class="col-sm-3 control-label" for="gccclsubscriptionId">Service Account Email Address</label>

        <div class="col-sm-9">
            <p id="gccclsubscriptionId" class="form-control-static">{{credential.parameters.serviceAccountId}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="gcclprojectId">Project Id</label>

        <div class="col-sm-9">
            <p id="gcclprojectId" class="form-control-static">{{credential.parameters.projectId}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
</form>
