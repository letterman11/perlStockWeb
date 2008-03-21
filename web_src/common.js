var TRUE = 1
var FALSE = 0
var LoginFormVisible = FALSE
var QueryFormVisible = FALSE
var stockIDLen = 10	
var SORT_PRICE = 0
var SORT_ORDER = 0
var SORT_DATE = 0
var CRITERION_DEFAULT_PAGE = 1
var handle = parent.top.document;


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
          return unescape(document.cookie.substring(j,cEnd))
       }
       i++
   }
   return null

}

function getCookie( name ) {
  var start = document.cookie.indexOf( name + "=" );
  var len = start + name.length + 1;
  if ( ( !start ) && ( name != document.cookie.substring( 0, name.length ) ) ) {
    return null;
  }
  if ( start == -1 ) return null;
  var end = document.cookie.indexOf( ";", len );
  if ( end == -1 ) end = document.cookie.length;
  return unescape( document.cookie.substring( len, end ) );

}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}


function tblSort(sortField)
{
	var SORT_CRITERION;

	if (sortField == 'PRICE') 
	{
		SORT_CRITERION = ++top.document.frmStockApp.sortCountPrice.value % 2  ?  'SORT_PRICE_DESC' : 'SORT_PRICE_ASC'
	}
	else if (sortField == 'ORDER')
	{
		SORT_CRITERION = ++top.document.frmStockApp.sortCountOrder.value % 2  ?  'SORT_ORDER_DESC' : 'SORT_ORDER_ASC'
	}
	else if (sortField == 'DATE')
	{
		SORT_CRITERION = ++top.document.frmStockApp.sortCountDate.value % 2  ?  'SORT_DATE_DESC' : 'SORT_DATE_ASC'
	} 

	
	top.document.frmStockApp.sortCriteria.value = SORT_CRITERION;
	

	var sortUrl = "/cgi-bin/stockReport.cgi?";	
        sortUrl += "stkName=" +escape(handle.frmStockApp.stkName.value) + "&minPrice=" +handle.frmStockApp.minPrice.value + "&maxPrice=" +handle.frmStockApp.maxPrice.value
       	        + "&minQty=" +handle.frmStockApp.minQty.value + "&maxQty=" +handle.frmStockApp.maxQty.value + "&rowsPerPage=" +handle.frmStockApp.rowsPerPage.value
		+ "&sort=" +handle.frmStockApp.sortCriteria.value;

	//alert(sortUrl);
        handle.getElementById('queryResult').src = sortUrl;

}
