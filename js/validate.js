function isNumeric(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if ((charCode > 31 && charCode !=46 )  && ((charCode < 48 || charCode > 57) && charCode!=190))
          {
	       alert("Enter Numeric value only");
	       return false;
	      }
         return true;
      }

function isAlpha(evt)
      {
		  
        var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 32 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122))
          {
	       alert("Enter letters only");
	       return false;
	      }
         return true;
      }

function isAlphaNumeric(evt)
{
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :((evt.which) ? evt.which : 0));    
	if (charCode = 31 && charCode >33  && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122))
	{
		alert("Enter numbers/letters only.");
		return false;
	}
	return true;
}

function isAlphaOnPaste(a){
	setTimeout(function()
       { 
          //get the value of the input text
          var data= a.value ;
          //replace the special characters to '' 
          var dataFull = data.replace(/[^\w\s]/gi, ' ');
          //set the new value of the input text without special characters
		  a.value = dataFull
       });
}

function trim(str)
{
	return str.replace(/^\s+|\s+$/g,"");
} 

