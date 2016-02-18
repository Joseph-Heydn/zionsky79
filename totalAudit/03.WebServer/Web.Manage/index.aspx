<%@ Page
	Language="C#"
	MasterPageFile="~/masters.master"
	AutoEventWireup="true"
	EnableViewState="false"
	CodeBehind="index.aspx.cs"
	Inherits="Web.Manage.index"
%>
<asp:Content ContentPlaceHolderId="cpStyles" runat="server">
	<style type="text/css">
		path.slice {
			stroke-width: 2px;
		}
		polyline {
			opacity: .3;
			stroke: black;
			stroke-width: 2px;
			fill: none;
		}
		svg text.percent {
			fill: white;
			text-anchor: middle;
			font-size: 12px;
		}
	</style>
</asp:Content>
<asp:Content ContentPlaceHolderId="cpScript" runat="server">
	<script type="text/javascript" src="/_common/amcharts_3.19.2.free/amcharts/amcharts.js"></script>
	<script type="text/javascript" src="/_common/amcharts_3.19.2.free/amcharts/serial.js"></script>
	<script type="text/javascript" src="/_common/_js/addon/d3.v3.min.js"></script>
	<script type="text/javascript" src="/_common/_js/addon/Donut3D.js"></script>
	<script type="text/javascript" src="/_common/_js/__calendar.js"></script>
	<script type="text/javascript" src="/_common/_js/__dashboard.js"></script>

	<script type="text/javascript">
		// 달력을 초기화 하는  Init
		if ( typeof(window.DP_InitPicker) != "undefined" ) {
			window.DP_InitPicker(1950);
		}

/**
 * 1 - #fcd202 : 노랑
 * 2 - #8a0ccf : 파랑
 * 3 - #04d215 : 초록
 * 4 - #ff9e01 : 주황
 * 5 - #8a0ccf : 자주
 * 6 - #cccccc : 연검
**/
		var vChartData = [
				{color:"#fcd202", visits:4025, country:"USA"}
			, 	{color:"#fcd202", visits:1882, country:"China"}
			, 	{color:"#fcd202", visits:1809, country:"Japan"}
			, 	{color:"#fcd202", visits:1322, country:"Germany"}
			, 	{color:"#fcd202", visits:1122, country:"UK"}
			, 	{color:"#fcd202", visits:1114, country:"France"}
			, 	{color:"#fcd202", visits:0984, country:"India"}
			];

		function fnShowChart(pChartName, pChartData) {
			AmCharts.makeChart
			(	pChartName
				,	{	type: "serial"
					,	dataProvider: pChartData
					,	categoryField: "country"
					,	depth3D: 8
					,	angle: 25
					,	categoryAxis: {
							labelRotation: 0
						,	gridPosition: "start"
						}
					,	valueAxes: [{title: ""}]
					,	graphs: [
						{	valueField: "visits"
						,	colorField: "color"
						,	type: "column"
						,	lineAlpha: 0
						,	fillAlphas: 1
						}]
					,	chartCursor: {
							cursorAlpha: 0
						,	zoomable: false
						,	categoryBalloonEnabled: false
						}
					,	"export": { "enabled": false }
				}
			);
		}


		fnShowChart("divChart01", vChartData);
		fnShowChart("divChart02", vChartData);

		fnShowChart("divChart11", vChartData);
		fnShowChart("divChart12", vChartData);

		fnShowChart("divChart21", vChartData);
		fnShowChart("divChart22", vChartData);

		fnShowChart("divChart31", vChartData);
		fnShowChart("divChart32", vChartData);

		$(document).ready(function() {
			var vSalesData = [
					{label:"Basic"	, value:1331, color:"#3366cc"}
				,	{label:"Plus"	, value:1248, color:"#dc3912"}
				,	{label:"Lite"	, value:0416, color:"#ff9900"}
				,	{label:"Elite"	, value:0084, color:"#109618"}
				,	{label:"Delux"	, value:0083, color:"#990099"}
				];

			var vChart = d3.select("#divChart03").append("svg").attr("width",172).attr("height",250);
			vChart.append("g").attr("id","pieChart01");

			vChart = d3.select("#divChart13").append("svg").attr("width",172).attr("height",250);
			vChart.append("g").attr("id","pieChart02");

			vChart = d3.select("#divChart23").append("svg").attr("width",172).attr("height",250);
			vChart.append("g").attr("id","pieChart03");

			vChart = d3.select("#divChart33").append("svg").attr("width",172).attr("height",250);
			vChart.append("g").attr("id","pieChart04");

			Donut3D.draw("pieChart01", vSalesData, 85, 130, 80, 60, 15, 0.3);
			Donut3D.draw("pieChart02", vSalesData, 85, 130, 80, 60, 15, 0.3);
			Donut3D.draw("pieChart03", vSalesData, 85, 130, 80, 60, 15, 0.3);
			Donut3D.draw("pieChart04", vSalesData, 85, 130, 80, 60, 15, 0.3);

			$(window).resize(function() {
				fnResizeTable();
			});

			fnResizeTable();
		});

		function fnResizeTable() {
			var divPie01 = $("#divPie01").width();
			$("#divTable03").width(divPie01 - 176);
			$("#divTable13").width(divPie01 - 176);
			$("#divTable23").width(divPie01 - 176);
			$("#divTable33").width(divPie01 - 176);
		}
	</script>
</asp:Content>

<asp:Content ContentPlaceHolderId="cpContents" runat="server">
	<div class="box">
		<div class="box-header">
			<h3 class="box-title">
				<i class="fa fa-dashboard"></i>
				<asp:Label Font-Size="9pt" Font-Bold="True" runat="server" meta:resourcekey="lblTitle_01"/>
			</h3>
			<div style="font-size:11px; display:inline-block; float:right;">
				<asp:Label EnableViewState="False" runat="server" meta:resourcekey="lblPeriod"/>
				<asp:TextBox id="txtStartDate" MaxLength="10" Width="80px" CssClass="cTextbox" runat="server"  />
				<img src="/_common/_images/icn_calendar20.gif" onclick="Calendar_D('<%= txtStartDate.ClientID %>',1);" class="imgC" alt=""/>
				<asp:CompareValidator id="CompareValidator1" ControlToValidate="txtStartDate" Display="None" Operator="DataTypeCheck" Type="Date" ValidationGroup="vg_search" runat="server"/>
				<asp:RequiredFieldValidator ControlToValidate="txtStartDate" Display="None" ValidationGroup="vg_search" runat="server"/>
				&nbsp;&nbsp;&nbsp;
				<asp:Label EnableViewState="False" runat="server" meta:resourcekey="lblInstence"/>
				<asp:TextBox id="txtFilter" Width="120px" CssClass="cTextbox" runat="server"/>
				<asp:Button OnClientClick="return fnSubmit();" CssClass="btn-xs" runat="server" meta:resourcekey="btnSearch"/>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="box">
			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblServer"/>
					<asp:Literal runat="server" meta:resourcekey="lblNear7"/>
				</div>
				<div id="divChart01" style="width:100%; height:250px;"></div>
			</div>
			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblServer"/>
					<asp:Literal runat="server" meta:resourcekey="lblTimely"/>
				</div>
				<div id="divChart02" style="width:100%; height:250px;"></div>
			</div>
			<div id="divPie01" style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblServer"/>
					<asp:Literal runat="server" meta:resourcekey="lblTop5"/>
				</div>
				<div id="divChart03" style="width:172px; height:250px; display:inline-block;"></div>
				<div id="divTable03" style="width:175px; height:250px; display:inline-block;">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; margin-top:15px; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:020px;"><asp:Literal runat="server" meta:resourcekey="lblNo"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblAction"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblCount"/></td>
						</tr>
					</table>
				</div>
			</div>

			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDML"/>
					<asp:Literal runat="server" meta:resourcekey="lblNear7"/>
				</div>
				<div id="divChart11" style="width:100%; height:250px;"></div>
			</div>
			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDML"/>
					<asp:Literal runat="server" meta:resourcekey="lblTimely"/>
				</div>
				<div id="divChart12" style="width:100%; height:250px;"></div>
			</div>
			<div id="divPie02" style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDML"/>
					<asp:Literal runat="server" meta:resourcekey="lblTop5"/>
				</div>
				<div id="divChart13" style="width:172px; height:250px; display:inline-block;"></div>
				<div id="divTable13" style="width:50%; height:250px; display:inline-block;">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; margin-top:15px; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:020px;"><asp:Literal runat="server" meta:resourcekey="lblNo"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblAction"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblCount"/></td>
						</tr>
					</table>
				</div>
			</div>

			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDDL"/>
					<asp:Literal runat="server" meta:resourcekey="lblNear7"/>
				</div>
				<div id="divChart21" style="width:100%; height:250px;"></div>
			</div>
			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDDL"/>
					<asp:Literal runat="server" meta:resourcekey="lblTimely"/>
				</div>
				<div id="divChart22" style="width:100%; height:250px;"></div>
			</div>
			<div id="divPie03" style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDDL"/>
					<asp:Literal runat="server" meta:resourcekey="lblTop5"/>
				</div>
				<div id="divChart23" style="width:172px; height:250px; display:inline-block;"></div>
				<div id="divTable23" style="width:50%; height:250px; display:inline-block;">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; margin-top:15px; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:020px;"><asp:Literal runat="server" meta:resourcekey="lblNo"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblAction"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblCount"/></td>
						</tr>
					</table>
				</div>
			</div>

			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDB"/>
					<asp:Literal runat="server" meta:resourcekey="lblNear7"/>
				</div>
				<div id="divChart31" style="width:100%; height:250px;"></div>
			</div>
			<div style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDB"/>
					<asp:Literal runat="server" meta:resourcekey="lblTimely"/>
				</div>
				<div id="divChart32" style="width:100%; height:250px;"></div>
			</div>
			<div id="divPie04" style="width:33%; height:250px; display:inline-block;">
				<div class="breadcrumb" style="width:80%; font-weight:bold; margin:10px 0 -3px 8px;">
					<asp:Literal runat="server" meta:resourcekey="lblDB"/>
					<asp:Literal runat="server" meta:resourcekey="lblTop5"/>
				</div>
				<div id="divChart33" style="width:172px; height:250px; display:inline-block;"></div>
				<div id="divTable33" style="width:50%; height:250px; display:inline-block;">
					<table class="table table-bordered" style="border-collapse:collapse; border:1px; width:100%; margin-top:15px; font-size:9pt;">
						<tr class="table table-bordered" style="background-color:#e9e9e9; font-weight:bold; text-align:center;">
							<td style="width:020px;"><asp:Literal runat="server" meta:resourcekey="lblNo"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblAction"/></td>
							<td><asp:Literal runat="server" meta:resourcekey="lblCount"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</asp:Content>
