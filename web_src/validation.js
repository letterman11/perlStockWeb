var handle = window.document;
var reEmailValidation = /^\w+[\w.]+?\w+@\w+[\w.]+?\.{1}\w+\s*$/;
var passLen = 6;
var userLen = 6;
var stock_UserID;


var ERRCODE = { 
		INVALID_PASSWORD:"Password length must be at least 6 characters", 
			PASSWORD_MISMATCH:"Passwords do not match"
		 };

 
//var Instance = getCookie('Instance');

function goSubmit()
{
   if (validateFields() == true)
   {
 
      var url = "../cgi-bin/stockReport.cgi?";
        url += "stkName=" +escape(handle.frmStockApp.stkName.value) + "&minPrice=" +handle.frmStockApp.minPrice.value + "&maxPrice=" +handle.frmStockApp.maxPrice.value
	  + "&minQty=" +handle.frmStockApp.minQty.value + "&maxQty=" +handle.frmStockApp.maxQty.value + "&rowsPerPage=" +handle.frmStockApp.rowsPerPage.value;

	//document.getElementsByTagName('iframe')[0].src = url;
	document.getElementById('queryResult').src = url;
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
  //alert('stockSessionID ' + stock_SessionID); 

  if ((stock_SessionID != null && stock_SessionID != 'null')) {
      document.getElementById('login').style.display='none';
      document.getElementById('queryForm').style.visibility='visible';
      document.getElementById('query').style.visibility='visible';
      document.getElementById('logged_on').style.visibility='visible';
      document.getElementById('stockList_container').style.visibility='visible';
      document.getElementById('stockListResult').src = "/cgi-bin/populate_stocklist.cgi";
      parent.top.document.frmStockApp.rowsPerPage.value = 25;

   }  
}

function init_profile()
{
   document.getElementById('login').style.display='none';
   document.frmProfile1.firstName.value = firstName;
   document.frmProfile1.lastName.value = lastName;
   document.frmProfile1.address1.value = address1;
   document.frmProfile1.address2.value = address2;
   document.frmProfile1.zipcode.value = zipCode;
   document.frmProfile1.city.value = city;
   document.frmProfile1.state.value = firstName;
   document.frmProfile1.firstName.value = firstName;
   document.frmProfile1.phone.value = firstName;
   document.frmProfile1.email.value = emailAddress ;
  // document.frmProfile1.submit.disabled = true ;
   document.frmProfile1.state.value = state ;




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

function clearValidationProfile1()
{
   var regForm = arguments[0];
   document.getElementById("val_email").style.visibility = "hidden";
//   document.getElementById("val_username").style.visibility = "hidden";
//   document.getElementById("val_password").style.visibility = "hidden";

}


function clearValidationProfile2()
{
   var regForm = arguments[0];

//   document.getElementById("val_email").style.visibility = "hidden";
   document.getElementById("val_password1").style.visibility = "hidden";
   document.getElementById("val_password2").style.visibility = "hidden";

}


function validateProfile1()
{
   var regForm = arguments[0];
   var state = true;

   clearValidationProfile1(regForm);

   var regForm = arguments[0];
   if (! reEmailValidation.test(regForm.email.value)) {
        document.getElementById("val_email").style.visibility = "visible";
        state = false
   }

/*   if(regForm.userName.value.length < userLen) {
        document.getElementById("val_username").style.visibility = "visible";
        state = false
   }
*/
   return false;
//   return state;
}

function validateProfile2()
{
   var regForm = arguments[0];
   var state = true;

   clearValidationProfile2(regForm);

   if(regForm.new_password.value != regForm.confirm_password.value) {

	document.getElementById("val_password1").innerHTML = ERRCODE.PASSWORD_MISMATCH;
	document.getElementById("val_password2").innerHTML = ERRCODE.PASSWORD_MISMATCH;
        document.getElementById("val_password1").style.visibility = "visible";
        document.getElementById("val_password2").style.visibility = "visible";
	
        state = false
   }

   if(regForm.new_password.value.length < passLen || regForm.confirm_password.value.length < passLen) {
	document.getElementById("val_password1").innerHTML = ERRCODE.INVALID_PASSWORD;
	document.getElementById("val_password2").innerHTML = ERRCODE.INVALID_PASSWORD;
        document.getElementById("val_password1").style.visibility = "visible";
        document.getElementById("val_password2").style.visibility = "visible";
        state = false
   }

   


   return false;
//   return state;

}

function logOut()
{
   for(i=0; i<arguments.length; i++) {
      eraseCookie(arguments[i]);
   }	
}


function setStockField()
{
	parent.top.document.frmStockApp.stkName.value = arguments[0];
}


function giveTop()
{
	return true;
}
