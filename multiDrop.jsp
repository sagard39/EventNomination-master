<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

<style>
select[name=employees] {
  width: 200px;
}
</style>
<script>
(function() {
  var data = {
    "employees": {
      "data": [{
        "id": 1,
        "name": "Sam Test 1"
      }, {
        "id": 2,
        "name": "Joe Test 2"
      }, {
        "id": 3,
        "name": "Joe Test 3"
      }, {
        "id": 4,
        "name": "Joe Test 4"
      }]
    }
  };
  $.each(data.employees.data, function(key, value) {
    $('select').append($("<option/>", {
      value: value.id,
      text: value.name
    }));
  });
  $("select[name=employees]").val(data.employees.data.map(function(x) {
    return x.id;
  })); // Set the selected data before show it.
  $('select').select2();
})();
</script>

<select name="employees" multiple="multiple"></select>