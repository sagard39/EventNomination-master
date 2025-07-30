var xmlHttp


function getLocDetails(str,str1)
{ 

if(str.length<4){return;}

xmlHttp=GetXmlHttpObject();
if (xmlHttp==null)
  {
  alert ("Your browser does not support AJAX!");
  return;
  } 

var url;
url="locdetails.jsp";
url=url+"?q="+str;
url=url+"&q2="+str1;


url=url+"&sid="+Math.random();
xmlHttp.onreadystatechange=stateChangedLoc12;
xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}




function stateChangedLoc12() 
{ 
//alert(xmlHttp.readyState);
if (xmlHttp.readyState==4)
{ 
document.getElementById("dontdel_loc").innerHTML=xmlHttp.responseText;
}
}



function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
return xmlHttp;
}

