<%--
    Copyright (c) 2014 IBM Corporation and others.
    All rights reserved. This program and the accompanying materials
    are made available under the terms of the Eclipse Public License v1.0
    which accompanies this distribution, and is available at
    http://www.eclipse.org/legal/epl-v10.html

    Contributors:
        IBM Corporation - initial API and implementation
 --%>
<!DOCTYPE html>
<html ng-app="collectiveManagementHandler">

<head>
  <meta charset="utf-8" />
  <title>Collective Management</title>
  <script src="jsCM/angular.min.js"></script>
  <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
  <script src="jsCM/collectiveManagementApp.js"></script>
  <link rel="stylesheet" href="css/desktopStyle.css" />
  <script src="jsCM/jquery-2.1.3.min.js"></script>
  
  <script type="text/javascript">
   	$(document).ready(function () {
 
    // Open in new window
    $( "#filterHosts" ).click(function() {
  		$( ".filterBox" ).slideToggle("fast", function() {
    		// Animation complete.
  		});
	});
    });  
    </script>
</head>

<body ng-controller="MainCtrl" id="angularData" >
	<div class="alert" id="successAlert" ng-hide="SuccessAlert">
		<p id="successAlertText">{{SuccessMessage}}</p>
	</div>
	<div class="alert" id="fialureAlert" ng-hide="FailAlert">
		<p id="failureAlertText">{{FailMessage}}</p>
	</div>
	<div class="filterBar" id="filterBarId">
		<div class="filterBarBlocks" id="filterBarBlock-Hosts" style="display:inline-block" tabindex="0">
			<div style="display:inline-block;" class="allHosts"></div>
			<div id="num" style="display:inline-block;">{{total}}</div>
			<div><p class="filterBarText">Hosts</p></div>
		</div>
		<div class="filterBarBlocks" id="filterBarBlock-Running" style="display:inline-block" tabindex="0">
			<div style="display:inline-block;" class="runningHosts"></div>
			<div id="num" style="display:inline-block;">{{running}}</div>
			<div><p class="filterBarText">Hosts With All Servers Running</p></div>
		</div>
		<div class="filterBarBlocks" id="filterBarBlock-Stopped" style="display:inline-block" tabindex="0">
			<div style="display:inline-block;" class="stoppedHosts"></div>
			<div id="num" style="display:inline-block;">{{stopped}}</div>
			<div><p class="filterBarText">Hosts With All Servers Stopped</p></div>
		</div>
		<div class="filterBarRight">
			<div class="filterBarBlocks" style="display:inline-block;" id="addNewHosts" ng-click="showPopup = ! showPopup" tabindex="0"><img src="./images/add-host-black.png" height="32px" width="32px"><span style="display:block;padding-top:6px;">Register New Host</span></div>
			<div class="filterBarBlocks" style="display:inline-block;" id="filterHosts" tabindex="0"><img src="./images/search-hosts-T.png" height="32px" width="32px"><span style="display:block;padding-top:6px;">Filter Hosts</span></div>
		</div>
	</div>
	<div class="filterBox" tabindex="0">
		<input ng-model="searchText" type="text" style="margin-left:40%;display:inline-block;">
		<img src="./images/search-breadcrumb-D.png" class="filterSearchIcon">
	</div>
	
	<!-- Popup to register a new host -->
	
	<div class="popup-background" style="width: 100%; height:100%; position: absolute; opacity: 0.4; left: 0px; top: 0px; z-index: 900;" ng-click="showPopup = ! showPopup" ng-show="showPopup"></div>
	<div class="popup" style="width: 200px; position: absolute; opacity: 1; left: 35%; top: 32%; z-index: 950;" ng-show="showPopup">
		<div  class="titleBar">
			<span  class="dijitDialogTitle" id="regDialog_title" >REGISTER HOST</span>
		</div>
		<div class="midLine">
		</div>
		<div class="dijitDialogPaneContent">
			<form>
				<div class="mblTextBox">
					<p class="mblText">Host Name:</p><input type="text" tabindex="0" id="box1" placeholder="Host Name" style="width:70%;" ng-model="hostToRegister.name">
				</div>
				<div class="mblTextBox">
					<p class="mblText">User Name:</p><input type="text" tabindex="0" id="box2" placeholder="User Name" style="width:70%;" ng-model="hostToRegister.username">
				</div>
				<div class="mblTextBox">
					<p class="mblText">User Password:</p><input type="password" tabindex="0" id="box3" placeholder="User Password" style="width:70%;" ng-model="hostToRegister.password">
				</div>
				<div style="text-align:center;">
					<button type="button" class="yesNoButton" tabindex="0" id="yes" style="-webkit-user-select:none;" style="background:#008abf;" ng-click="registerHost(hostToRegister);showPopup = ! showPopup;">Register</button>
					<button type="button" class="yesNoButton" tabindex="0" id="no" style="-webkit-user-select: none;" style="background:#58595b;" ng-click="showPopup = ! showPopup">Cancel</button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- getting invisible background -->
	<div class="popup-background" style="width: 100%; height:100%; position: absolute; opacity: 0.1; left: 0px; top: 0px; z-index: 900;" ng-click="popupBack = ! popupBack" ng-show="popupBack" id="updateBackground"></div>
	<!-- Update popup -->
	<div class="popup-background" style="width: 100%; height:100%; position: absolute; opacity: 0.4; left: 0px; top: 0px; z-index: 900;" ng-click="showUpdatePopup = ! showUpdatePopup" ng-show="showUpdatePopup" id="updateBackground"></div>
	<div class="popup" style="width: 200px; position: absolute; opacity: 1; left: 35%; top: 32%; z-index: 950;" ng-show="showUpdatePopup" id="updateBox">
		<div  class="titleBar">
			<span  class="dijitDialogTitle" id="regDialog_title" >UPDATE HOST {{updateHostName}}</span>
		</div>
		<div class="midLine">
		</div>
		<div class="dijitDialogPaneContent">
			<form>
				<div class="mblTextBox">
					<p class="mblText">User Name:</p><input type="text" tabindex="0" id="box2" placeholder="User Name" style="width:70%;" ng-model="updateHostData.user">
				</div>
				<div class="mblTextBox">
					<p class="mblText">User Password:</p><input type="password" tabindex="0" id="box3" placeholder="User Password" style="width:70%;" ng-model="updateHostData.pwd">
				</div>
				<div style="text-align:center;">
					<button type="button" class="yesNoButton" tabindex="0" id="yes" style="-webkit-user-select:none;" style="background:#008abf;" ng-click="updateHost(updateHostData); showUpdatePopup = ! showUpdatePopup;">Update</button>
					<button type="button" class="yesNoButton" tabindex="0" id="no" style="-webkit-user-select: none;" style="background:#58595b;" ng-click="showUpdatePopup = ! showUpdatePopup">Cancel</button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- Main display area where all cards are being displayed -->
	<div class="main">
		<div class="hostDisplayCards" ng-repeat="host in hosts | filter:searchText | orderBy: 'hostName'" >
		<div class="mainHostCard-Wrapper">
			<div class="mainHostCard">
				<div class="hostDisplayCard-Text">
					<div class="hostDisplayCard-HostName">
						<div style="position: absolute;right: -11px;bottom: 70px;cursor: pointer;" tabindex="0"><img src="images/card-action-T.png" height="24" width="24" alt="Host" ng-click="setPopup();dropDownCard = ! dropDownCard"></div>
						<div class="popup-background" style="width: 100%; height:100%; position: absolute; opacity: 0; left: 0px; top: 0px; z-index: 900;" ng-click="dropDownCard = ! dropDownCard" ng-show="dropDownCard"></div>
						<div class="dropdown-ActionBox" ng-show="dropDownCard">
							<div style="position:absolute;left:8px;top:-14px;"><img src="images/triangle-connector-upward-dialog-confirmation-T.png"></div>
							<div class="dropdown-ActionBoxUpdate" ng-click="setUpdateHostName(host.hostName);dropDownCard = ! dropDownCard;" tabindex="0">
								<div style="display:inline-block;padding-top:10px;"><img src="images/Update.png" height="20px" width="20px"></div>
								<div>UPDATE</div>
							</div>
							<div class="dropdown-ActionBoxUnregister" ng-click="unregisterHost(host.hostName);dropDownCard = ! dropDownCard;" tabindex="0">
								<div style="display:inline-block;padding-top:10px;"><img src="images/action-menu-stop-T.png" height="20px" width="20px"></div>
								<div>UNREGISTER</div>
							</div>
						</div> 
						<div class="hostImage"><img src="images/card-host-T.png" height="24" width="24" alt="Host" ></div>
						<div class="hostName">{{host.hostName}}</div>
					</div>
					<div class="hostDisplayCard-Count">
						<div class="ServerImage" style="display:inline-block"><img src="images/card-server-S.png" height="16" width="16" alt="Server"></div>
						<div class="ServerStats" style="display:inline-block">{{host.runningServers}}/{{host.totalServers}} servers running</div>
						<!--<svg height="3" width={{host.runningSize}} style="display:block;padding:left">
  							<line x1="0" y1="0" x2={{host.runningSize}} y2="0" style="stroke:rgb(36,158,108);stroke-width:3" />
							<line x1={{host.runningSize}} y1="0" x2={{host.runningSize+host.unknownSize}} y2="0" style="stroke:rgb(110, 118, 122);stroke-width:3" />
							<line x1={{host.runningSize+host.unknownSize}} y1="0" x2={{host.runningSize+host.unknownSize+host.stoppedSize}} y2="0" style="stroke:rgb(255,0,0);stroke-width:3" />
						</svg>-->
					</div>
				</div>
				<div class="mainServerCard" id={{host.hostName}}-expandableDiv ng-show="showDetails">
					<select multiple size="5" class="hostDisplayCard-Servers" ng-model="multiServerValues" >
						<option ng-repeat="server in host.hostData" value="{{server.serverName}}">{{server.serverName}}</option>
					</select>
				<div class="managementButtons"> 
					<!-- <div class="serverMoreButton" ng-click="getmoreDetails = ! moreDetails;"></div> -->
					<div class="serverDeleteButton" ng-click="removeServer(host.hostName,multiServerValues)" tabindex="0"></div>
				</div>
				</div>
				<div class="hostDisplayCard-Button-Wrapper" id={{host.hostName}}-expandableButton ng-click="getHostServerData(host.hostName);showDetails = ! showDetails;" tabindex="0">
				<div class="hostDisplayCard-Button" ng-show="!showDetails">
					<img src="images/show-hide-graphs-right-T.png" height="24px" width="10px" style="padding-left:3px;">
				</div>
				<div class="hostDisplayCard-Button" ng-show="showDetails">
					<img src="images/show-hide-graphs-left-T.png" height="24px" width="10px" style="padding-left:3px;">
				</div>
				</div>
			</div>
		</div>
		</div>
	</div>

</body>

</html>

