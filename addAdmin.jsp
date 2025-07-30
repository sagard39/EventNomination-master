<%@ include file ="header1.jsp"%>'

<script>
	function goDel(rowid){
		if(!confirm("Are you sure,Do you really want to Delete?"))
			return false;
		else {	
			document.form1.action.value = rowid;
			document.form1.submit();
		}	
	}
</script>
<%! public String nullVal(String newStr){
		String strVal = newStr;
		if(newStr==null){
			strVal = "";
		}else if(newStr.trim().equals("null")){
			strVal = "";
		} else if("".equals(newStr)){
			strVal = "";
		}
	return strVal;
}%>

<div class= "container">
<form name="form1" method ="post" class = "needs-validation" novalidate>
<input type ="hidden" name = "action" value  ="" /> 
<%
String queryEmp = "";
PreparedStatement psNew = null;
ResultSet rsNew = null;
String action = nullVal(request.getParameter("action"));

String adminAction = nullVal(request.getParameter("addAdmin")); 
if(adminAction.equals("Add")){
	queryEmp = "insert into nomination_super (EMP_NO,ROLE,FROM_DATE,TO_DATE,CREATED_DATE,UPDATED_BY) values(?,?,?,?,sysdate,?)";
	psNew = con.prepareStatement(queryEmp);
	psNew.setString(1,request.getParameter("addEmp"));
	psNew.setString(2,request.getParameter("adminType"));
	psNew.setString(3,request.getParameter("from_date"));
	psNew.setString(4,request.getParameter("to_date"));
	psNew.setString(5,login1);
	int psCount = psNew.executeUpdate();
	if(psCount>0){%>
		<script>
			alert("Added Successfully");
			location.href = "addAdmin.jsp";
		</script>
	<%}
}
if(!"".equals(action)){
	queryEmp ="delete from nomination_super where rowid =?";
	psNew = con.prepareStatement(queryEmp);
	psNew.setString(1,action);
	int psCount = psNew.executeUpdate();
	if(psCount>0){%>
		<script>
			alert("Deleted Successfully");
			location.href = "addAdmin.jsp";
		</script>
	<%}	
}
Statement stmtNew  = con.createStatement();
rsNew = stmtNew.executeQuery("select rowid,emp_no,(select trim(emp_name) emp_name from empmaster where emp_no =a.emp_no)emp_name,decode(role,'Technical_Admin','Technical Admin','Process_Admin','Process Admin',role) role,to_char(CREATED_DATE,'dd-Mon-yyyy') updated_date, to_char(FROM_DATE,'dd-Mon-yyyy') as from_date, to_char(TO_DATE,'dd-Mon-yyyy') as to_date from nomination_super a ");
%>
<div class = "row" >
<div class="col-md-4 order-md-2 mb-4" >
	<div class = "card md-10 box shadow">
		<div class = "card-header alert alert-primary style-app-name"><h5 class="text-white">Members</h5></div>
		<div class ="card-body">
		<%while(rsNew.next()){%>
			<li class="list-group-item d-flex justify-content-between lh-condensed">
				<div><h6 class = "my-0"><%=nullVal(rsNew.getString("emp_name"))%>(<%=nullVal(rsNew.getString("emp_no"))%>)</h6>
				<small class="text-muted">(Added on : - <%=nullVal(rsNew.getString("updated_date"))%>)</small><br>
				<small class="text-muted">(Valid from: - <%=nullVal(rsNew.getString("from_date"))%>)</small>
				<small class="text-muted">(Valid upto: - <%=nullVal(rsNew.getString("to_date"))%>)</small>
			</div>
				<h6 class = "my-0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h6>
				<h6 class = "my-0"><%=rsNew.getString("role")%></h6>
				<div><a class = "my-0" style = "cursor:pointer;" onclick ="return goDel('<%=rsNew.getString("rowid")%>')"><img style="width:20px; height: 20px;" src = "images/clear.png"></a></div>
			</li>
		<%}%>
		</div>
    </div>
</div>
<div class ="col-md-8 order-md-1" >
<div class ="card md-10 box shadow">
<div class ="card-header  alert alert-primary style-app-name"><h5 class="text-white">Add Admin Member</h5></div>
<div class ="card-body" style="padding: 2.5rem;">

	<div class = "row form-group">
		<div class="col-md-3"><label for = "adminType">Select the Role for Admin: </label></div>
		<div class="col-md-3"><select class = "select-field" name = "adminType" id = "adminType" required>
				<option value ="">Select</option>
				<option value ="Technical_Admin">Technical Admin</option>
				<option value ="Process_Admin">Process Admin</option>
				<!-- <option value ="Super_Admin">Super Admin</option>
				<option value ="Admin">Admin</option> -->
			</select>
			<div class = "invalid-feedback">
				Select Admin Type
			</div>
		</div>

		<div class="col-md-3"><label for = "addEmp">Enter Employee No: </label></div>
		<div class="col-md-3"><input type = "text" class ="select-field" name = "addEmp" id = "addEmp" required/>
			<div class = "invalid-feedback">
				Enter Employee No
			</div>
		</div>
  </div>

  

  <div class = "row form-group">
  	<div class="col-md-3"><label for = "addEmp">From Date: </label></div>
		<div class="col-md-3"><input type="text" name="from_date" class="select-field datepicker" id="from_date" readonly></div>	

		<div class="col-md-3"><label for = "addEmp">To Date: </label></div>
		<div class="col-md-3"><input type="text" name="to_date" class="select-field datepicker" id="to_date" readonly></div>
	</div>

  <div class = "row form-group style-right style-right-align"> 
	<button  type ="submit" class = "style-right-button" name ="addAdmin" value = "Add">Add Admin</button>
  </div>
 </div> 
</form>  
</div>
</div>
</div></div>
<script>

	$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			dateFormat: "dd-M-yy",
			minDate: new Date(),
			
			
		});
// Example starter JavaScript for disabling form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
</script>
<%@include file="footer.jsp"%>