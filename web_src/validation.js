var handle = window.document;

function goSubmit()
{
  if (validateFields() == true)
  {
 
	 var url = "../cgi-bin/stockReport.cgi?";
//	 var url = "http://localhost:8080/~abrooks/StockApp/cgi-bin/stockReport.cgi?";
//	 var url = "http://192.168.1.101:8080/~abrooks/StockApp/cgi-bin/printenv.cgi";

	 url += "stkName=" +escape(handle.frmStockApp.stkName.value) + "&minPrice=" +handle.frmStockApp.minPrice.value + "&maxPrice=" +handle.frmStockApp.maxPrice.value
	  + "&minQty=" +handle.frmStockApp.minQty.value + "&maxQty=" +handle.frmStockApp.maxQty.value;
	 
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

function server_vallidate(stockAppID)
{
   var url = "http://192.168.1.104:8080/~abrooks/StockApp/cgi-bin/authenticate.cgi?stockSessionID=stockAppID"; 
   window.location = url;
}

function init()
{
   var stock_SessionID;
   stock_SessionID = getCookieData('stockApp_Session');
   
   if ((stock_SessionID == null) || (stock_SessionID.length < stockIDLen)) {

      document.getElementById('pageheader2').style.visibility='visible';
      document.getElementById('queryForm').style.visibility='hidden';
   } else if (stock_SessionID != null) 
   {
      server_validate(stock_SessionID);
   }
}

function init_old()
{
   var stock_ID;
   stock_ID = getCookieData('stockApp_ID');
   server_validate(stock_ID);
   if ((stock_ID != null)  (stock_ID.length < stockIDLen)) {

    document.getElementById('queryForm').style.visibility='visible'
//      document.getElementById('queryForm').style.visibility='visible'
//    var url = "http://192.168.1.101:8080/~abrooks/StockApp/cgi-bin/stockReport.cgi?"

   } else {

      document.getElementById('queryForm').style.visibility='visible'

   }
}

