<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.0/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

  </head>
  <body>

  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" data-hover="dropdown">
   Dropdown <span class="caret"></span>
  </button>
  <div class="collapse navbar-collapse" data-hover="dropdown" data-animations="fadeInDown fadeInRight fadeInUp fadeInLeft">
    <ul class="nav navbar-nav">
  
    <li><a href="#">Action</a></li>
    <li><a href="#">Another action</a></li>
    <li class="dropdown">
      <a href="#">One more dropdown</a>
      <ul class="dropdown-menu">
        <li><a href="#">Action</a></li>
        <li><a href="#">Another action</a></li>
        <li class="dropdown">
          <a href="#">One more dropdown</a>
          <ul class="dropdown-menu">
          ...
          </ul>
        </li>
        <li><a href="#">Something else here</a></li>
        <li><a href="#">Separated link</a></li>
       </ul>
    </li>
    <li><a href="#">Something else here</a></li>
    <li><a href="#">Separated link</a></li>
	</ul>
	</div>
	
    
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Bootstrap Dropdown Hover JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-hover-dropdown/2.2.1/bootstrap-hover-dropdown.min.js"></script>
  </body>
</html>