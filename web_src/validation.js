var handle = window.document;

function goSubmit()
{
   if (validateFields() == true)
   {
 
      var url = "../cgi-bin/stockReport.cgi?";
        url += "stkName=" +escape(handle.frmStockApp.stkName.value) + "&minPrice=" +handle.frmStockApp.minPrice.value + "&maxPrice=" +handle.frmStockApp.maxPrice.value
	  + "&minQty=" +handle.frmStockApp.minQty.value + "&maxQty=" +handle.frmStockApp.maxQty.value + "&rowsPerPage=" +handle.frmStockApp.rowsPerPage.value;

      window.open(url);
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
}


function init()
{

   stock_SessionID = getCookieData('stock_SessionID');
   //alert('stockSessionID ' + stock_SessionID + 'length ' + stock_SessionID.length ); 

   if ((stock_SessionID != null) && (stock_SessionID.length >= stockIDLen)) {
      document.getElementById('login').style.visibility='hidden';
      document.getElementById('queryForm').style.visibility='visible';
   }  
}


