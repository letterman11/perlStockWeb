var TRUE = 1
var FALSE = 0
var LoginFormVisible = FALSE
var QueryFormVisible = FALSE
var stockIDLen = 10	




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
