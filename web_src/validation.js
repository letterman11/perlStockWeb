

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

