var handle = window.document;
var reEmailValidation = /^\w+[\w.]+?\w+@\w+[\w.]+?\.{1}\w+\s*$/;
var passLen = 6;
var userLen = 6;
var stock_UserID;
var Instance = getCookie('Instance');

function goSubmit()
{
   if (validateFields() == true)
   {
 
      var url = "../cgi-bin/stockReport.cgi?";
        url += "stkName=" +escape(handle.frmStockApp.stkName.value) + "&minPrice=" +handle.frmStockApp.minPrice.value + "&maxPrice=" +handle.frmStockApp.maxPrice.value
	  + "&minQty=" +handle.frmStockApp.minQty.value + "&maxQty=" +handle.frmStockApp.maxQty.value + "&rowsPerPage=" +handle.frmStockApp.rowsPerPage.value;

	//document.getElementsByTagName('iframe')[0].src = url;
	document.getElementById('queryResult').src = url;
//      window.open(url);
   }

}

function validateFields()
{
   if(handle.frmStockApp.stkName.value == "" || handle.frmStockApp.stkName.value == "undefined" || handle.frmStockApp.stkName.value == null ||
    handle.frmStockApp.stkName.value == "null")
   {
       alert("Must Supply a Stock Symbol");
       return false;
   }
   else
   {
       return true;
   }

}

function clearFields(handler)
{

   handle.frmStockApp.stkName.value="";
   handle.frmStockApp.minPrice.value="";
   handle.frmStockApp.maxPrice.value="";
   handle.frmStockApp.minQty.value="";
   handle.frmStockApp.maxQty.value="";
   handle.frmStockApp.rowsPerPage.value="";
}


function init()
{

   stock_SessionID = getCookie('stock_SessionID');
   //alert('stockSessionID ' + stock_SessionID + 'length ' + stock_SessionID.length ); 

   if ((stock_SessionID != null || stock_SessionID != 'null') && (stock_SessionID.length >= stockIDLen)) {
      document.getElementById('login').style.display='none';
      document.getElementById('queryForm').style.visibility='visible';
      document.getElementById('query').style.visibility='visible';
      document.getElementById('logged_on').style.visibility='visible';

   }  
}

function init_profile()
{
	
   document.frmRegister.firstName.value = firstName;
   document.frmRegister.lastName.value = lastName;
   document.frmRegister.address1.value = address1;
   document.frmRegister.address2.value = address2;
   document.frmRegister.zipcode.value = zipCode;
   document.frmRegister.city.value = city;
   document.frmRegister.state.value = firstName;
   document.frmRegister.firstName.value = firstName;
   document.frmRegister.phone.value = firstName;
//   document.frmRegister.state.value = firstName;
//  document.frmRegister.state.value = firstName;


}

function validateRegistration()
{
   var regForm = arguments[0];
   var state = true;

   clearValidationRegistration(regForm);

   var regForm = arguments[0];
   if (! reEmailValidation.test(regForm.email.value)) {
	document.getElementById("val_email").style.display = "block";
        state = false
   }

   if(regForm.userName.value.length < userLen) {
        document.getElementById("val_username").style.display = "block";
        state = false
   }

   if(regForm.password.value.length < passLen) {
	document.getElementById("val_password").style.display = "block";
        state = false
   }

//   return false;
   return state;

}

function clearValidationRegistration()
{
   var regForm = arguments[0]; 
   document.getElementById("val_email").style.display = "none";
   document.getElementById("val_username").style.display = "none";
   document.getElementById("val_password").style.display = "none";

}

function logOut()
{
   for(i=0; i<arguments.length; i++) {
      eraseCookie(arguments[i]);
   }	
}
