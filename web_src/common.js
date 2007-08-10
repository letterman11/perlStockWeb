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
   return ""

}

