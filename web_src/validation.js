

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

function clearFields()
{
  handle.frmStockApp.stkName.value="";
  handle.frmStockApp.minPrice.value="";
  handle.frmStockApp.maxPrice.value="";
  handle.frmStockApp.minQty.value="";
  handle.frmStockApp.maxQty.value="";
}


function authenticate()
{

   var stock_ID
   stock_ID = getCookieData('stockApp_ID');
   if (stock_ID.length == 0) || (stock_ID = null) {
      var url = 
      document.href = O
   } else {


   }

   document.href= url;

}

//stolen cookie function
function getCookieData(label) 
{
   var labelLen = label.length
   var cLen = document.cookie.length
   var i = 0
   var cEnd
   while (i < cLen) {
       var j = i + labelLen
       if (document.cookie.substring(i,j) == label) {
          cEnd = document.cookie.indexOf(";",j)
	  if (cEnd == -1) {
	     cEnd = document.cookie.length 
          } 
	  return unescape(document.cookie.substring(j,cEnd)
       }
       i++
   }
   return ""

} 
