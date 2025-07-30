<%@ include file="header1.jsp"%>
<link href="css/select2.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/select2.min.js"></script>

<style>
.target_popup {position: relative; background: white; padding: 20px; width: auto; max-width: 800px; margin: 20px auto; box-shadow: 0 0 12px #fff; border-radius: 5px;}
h2,h3,h4,.tdLbl1{
    padding: 2px 10px;
    color:#18568e;
    font-weight: bold;
    font-size: 14px;
   }
 

@media (max-width: 768px) { /* use the max to specify at each container level */
    .specifictd {    
        width:360px;  /* adjust to desired wrapping */
        display:table;
        white-space: pre-wrap; /* css-3 */
        white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
        white-space: -pre-wrap; /* Opera 4-6 */
        white-space: -o-pre-wrap; /* Opera 7 */
        word-wrap: break-word; /* Internet Explorer 5.5+ */
    }
} 
</style>
<script>
function getLocnBy(Obj){
	var locnBy=Obj.value;
	if(locnBy=='t'){
		$('#evtplace').select2();
		$("#divTown").show();
		$("#divBu").hide();
	}
	if(locnBy=='b'){
		$('#buDesc').select2();
		$("#divBu").show();
		$("#divTown").hide();
	}
}
function get(){
	var q=document.getElementById("evtplace").value;
	alert(q)
	if(q != "") {
		//if(totalArea==1) {
		//ajaxindicatorstart('Please Wait...');			
		$.ajax({
			type: "post",
			url: "List1.jsp",
			data: {q:q},
			success: function(jsonData){
				alert(jsonData);
			//ajaxindicatorstop();
			jsonObj = JSON.parse(jsonData);
			//alert(jsonObj.length);
			for(var i = 0; i < jsonObj.length; i++) {
				//$("#emp_name"+id).val(jsonObj[i].srp);
            	/*$("#item_desc"+id).html(jsonObj[i].itemdesc);
				$("#tax_item_desc"+id).html(jsonObj[i].tax_item_desc);*/
				//$("#tax_itemdesc"+id).val(jsonObj[i].tax_item_desc);
				//$("#basic").val(jsonObj[i].emp_name);
				$("#list").append("<option value='"+jsonObj[i].emp_name+"' Selected>"+jsonObj[i].emp_name+"</option>");
			
			}
			
		},
		error: function(jsonData, status, error){
			//ajaxindicatorstop();
			alert("Some Error occured");
		}
		});
		//}
	} else {
		$("#srp"+id+"").not(':first').remove();
		//$("#customer"+id+" option").not(':first').remove();
	}
}	  

</script>

<script language="Javascript">
function delrec(r,a){
	location.replace('editevent.jsp?del='+r+'&twn='+a);
}
  function formsubmit(frmname) {
	  $("form[name='"+frmname+"']").submit();
}
</script>
<div class="container"><div class="row">
	<!--<div class="" style="margin-left:10%">
		<div class="fl mr10"><h4>Event List</h4><img class="curpoint" onclick="toggleHist(this)" src="images/expand4.png" /></div>
		<div class="clear"></div>
		</div>-->
<div id="hist_table" class="card md-10 box shadow border-primary">
<div class="card-header bg-primary"><h3 class="text-white">Edit Event</h3></div>
	<div class="card-body table-responsive">
		<table id="tab1" style="table-layout: fixed;" class="table table-bordered table-hover">
			<thead class ="alert alert-success"><tr><th >Event Name</th><th >Event date</th><th >Event Location</th><th style="">Last date for Event</th><th style="">Price per ticket</th><th style="">Total Tickets</th><th>Max Tickets</th><th style="">Action</th></thead></tr>
			<tbody>
			<%
			Statement st=con.createStatement();
			ResultSet rs1 = null;
			int cnt = 0;
			String dbevtnme="",dbevtplace="",dbcutofdte="",dbpriceevt="",dbnooftickts="",dbinditick ="",dbevtDate="",evtqry="";
			if(isDefAdmin)
					evtqry="select to_char(CUTOFDTE,'dd-Mon-yyyy'),MAXTICK,MAXPRICE,EVTNME,EVTPLACE,INDIV_TICK,to_char(evt_date,'dd-Mon-yyyy') evt_date1,EVT_ID,status from nomination_admin where evt_id is not null order by evt_date desc";
			else		
				evtqry="select to_char(CUTOFDTE,'dd-Mon-yyyy'),MAXTICK,MAXPRICE,EVTNME,EVTPLACE,INDIV_TICK,to_char(evt_date,'dd-Mon-yyyy') evt_date1,EVT_ID,status from nomination_admin where evt_id is not null and regexp_like(adminemp, '"+adminComp+"', 'i') order by evt_date desc";
			//out.println(evtqry);
			rs1=stmt.executeQuery(evtqry);
			
			while(rs1.next()){
				dbcutofdte = rs1.getString(1);
				dbnooftickts = rs1.getString(2);
				dbpriceevt = rs1.getString(3);
				dbevtnme = rs1.getString(4);
				dbevtplace = rs1.getString(5);
				dbinditick = rs1.getString(6);
				dbevtDate=rs1.getString("evt_date1");
				cnt++;
			%>
			<tr>
				<td><%=dbevtnme%></td>
				<td><%=rs1.getString("evt_date1")%></td>
				<td style= "widht:10%"><%=dbevtplace%></td>
				<td><%=dbcutofdte%></td>
				<td><%=dbpriceevt%></td>
				<td><%=dbnooftickts%></td>
				<td><%=dbinditick%></td>
				<td>
					<%SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
					Date currentdte =new Date();
					Date dbdate = new Date(dbcutofdte);
					Date dbEvtDate=new Date(dbevtDate);
					String currentdteval = fmt.format(currentdte);%>
					<% if((currentdte.before(dbEvtDate) || currentdteval.equals(dbevtDate)) && "S".equals(rs1.getString("status"))){%>
							
							<!--<input type="submit" name="publishEvt" id="publishEvt" value="Publish Event">-->
					
					<form name="formdel<%=cnt%>" action="delevent.jsp" method="post">
						<div>
							<!--updateEvent.jsp--<img src="images/clear.png" style="width:40%;height:auto;cursor:pointer" onclick="formsubmit('formdel<%=cnt%>');" title="Delete">-->
							<a href="newEvent.jsp?editId=<%=rs1.getString("evt_id")%>" class =""><img src="images/edit.png" style="width:15%;height:auto;cursor:pointer"  title="Edit" width="20" ></a>
						<!--	<a href="#"><img src="images/edit.png" style="width:25%;height:auto;" title="Edit" ></a> -->
						</div>
						<input type="hidden"name="del" id="del" value="<%=dbevtnme%>">
						<input type="hidden"name="twn" id="twn" value="<%=dbevtplace%>">
					</form>
					<% } %>
				</td>
			</tr>
		<%}%>
		</tbody>
	</table>
</div>

</div>
</div>
<script>
$(function() {
	$('.ajax_popup_link').magnificPopup({ type: 'ajax', });

});

</script>
