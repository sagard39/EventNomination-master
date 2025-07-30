<%@ include file = "header1.jsp"%>
<link href="css/select2.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/select2.min.js"></script>

<script>
/* $( document ).ready(function() {
 $('.js-data-example-ajax').select2({
  ajax: {
	type :'post', 
    url: 'townLocn.jsp',
    dataType: 'json',
	delay: 250,
	data: {emp_no:'M'},
	processResults: function (data) {
      // Tranforms the top-level key of the response object from 'items' to 'results'
      return {
        results: data
      };
    },
	cache: true
  },
	placeholder: 'Search for a repository',
	escapeMarkup: function (markup) { return markup; },
	templateResult: formatRepo,
	templateSelection: formatRepoSelection
});

});
function formatRepo (repo) {
	var markup = "<div class='abc'>"+repo.emp_name+"</div>";
	return markup;
}
function formatRepoSelection (repo) {
  return repo.emp_name;
} */
</script>
<script type="text/javascript">
$( document ).ready(function() {
  $('select').select2();
});
</script>
<script>
$( document ).ready(function() {

$("#supplier").select2({
    tags: true,
    multiple: true,
    tokenSeparators: [',', ' '],
    minimumInputLength: 4,
    //minimumResultsForSearch: 10,
    ajax: {
        url: "townLocn.jsp",
        //dataType: "json",
        type: "Post",
        data: function (params) {
            var queryParameters = {
                term: params.term
            }
            return queryParameters;
        }, 
		processResults: function (data) {
            var myResults = [];
            jsonObj = JSON.parse(data);
						for(var i = 0; i < jsonObj.length; i++) {
                myResults.push({
                    'id': jsonObj[i].id,
                    'text': jsonObj[i].text
                });
            }
            return {
                results: myResults
            };
        }
  }
});
});
</script>




<body><br>
<div class ="container">
<select name="supplier" id="supplier" class ="form-control" multiple="multiple" style="width:295px">
		<option value="">Select</option>
		<option value="ba" selected>Ba</option>
		<option value="ca" selected>Ca</option>
		</select>
</div>
</body>
<%@ include file ="footer.jsp"%>