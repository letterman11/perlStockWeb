package GenHome;

@ISA = qw(GenView);

use strict;
use CGI qw /:standard/;

sub new
{
	my $self = {};
	my $class = shift;
	$self->{COOKIES} = shift;
	bless ($self,$class);
	return $self;

}


sub display
{
	my $self = shift;
	my $cookieList = $self->{COOKIES};
	my $out_buffer=();

	print header(-cookie=>$cookieList);
	
	$out_buffer = <<"OUT_HTML";
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Stock Query Application - Registration </TITLE>
        <LINK href="$::URL_PATHS->{MAINSTYLE_CSS}" rel="stylesheet" type="text/css">
        <script language="Javascript" src="$::URL_PATHS->{VALIDATION_JS}"> </script>
        <script language="Javascript" src="$::URL_PATHS->{COMMON_JS}"> </script>
    </HEAD>
<BODY onload="init()">

<div id="main">
        <div id="banner">
         <a href="$::URL_PATHS->{STOCKAPP_HTM}">    <img id="banner_image" src="$::URL_PATHS->{BANNER_IMAGE}">  </a>
         <a href="$::URL_PATHS->{NEWSITE_HTM}">    <img id="banner_image2" src="$::URL_PATHS->{BANNER_IMAGE2}">  </a>
        </div>

        <div id="login" style="visibility:visible">
          <form name="frmLogin" method="POST" action="../cgi-bin/authenticate.cgi">
             <table>
              <tr class="form_login">
                  <td> user name: </td> <td> <input name="userName" type="text"> </td>
              </tr>
              <tr class="form_login">
                  <td> password:  </td> <td> <input name="userPass" type="password"> </td>
              </tr>
              <tr class="form_login">
                  <td colspan="2"> <input type="submit"> <input type="reset"> </td>
              </tr>
              <tr class="form_login">
                  <td> Not Registered?   Register <a href="$::URL_PATHS->{REGISTRATION_HTM}"> here </a> </td>
              </tr>
              </table>
          </form>
        </div>

	<div id="logged_on" style="visibility:visible">
         <span class="form_login">  
 	   <script language="Javascript" type="text/javascript">
	     stock_UserID = getCookie('stock_UserID'); 
             if(stock_UserID != null && stock_UserID.length > 0) {
		document.write(stock_UserID + " LOGGED IN | " + 
	   	" <a href=$::URL_PATHS->{STOCKAPP_HTM} onclick=logOut('stock_UserID','stock_SessionID','Instance') target=_top > LOG OUT </a> " + 
	   	" | <a href=/cgi-bin/profile_page.cgi?userName=" + stock_UserID + ">" +  " update profile </a> "); 
	     }
	  </script>
	 </span>
	</div>
</div>

<div id="sub_left_panel">
   <div id="queryForm" style="visibility:hidden">
       <form id="frmStockApp" name="frmStockApp">
        <table class="form_query">
          <tr>
           <td>Stock Name: </td> <td> <input name="stkName" type="text" onBlur="changeBigStock(document);"> </td>
           </tr>
          <tr>    
           <td>Min Price: </td> <td> <input name="minPrice" type="text"></td>
          </tr>
          <tr>
            <td>Max Price: </td> <td><input name="maxPrice" type="text"></td>
          </tr>
          <tr>
           <td>Min Quantity: </td> <td><input name="minQty" type="text"></td>
          </tr>
          <tr>
           <td> Max Quantity: </td> <td><input name="maxQty" type="text"></td>
         </tr>
         <tr>
            <td> # of rows:  </td> <td> <select id="rowsPerPage" name="rowsPerPage">
	        <option value="10">10</option>
       		<option value="15">15</option>
      		<option value="20">20</option>
      		<option value="25">25</option>
        	<option value="30">30</option>
        	<option value="50">50</option>
	</td>
         </tr>
         <tr>
           <td> <input type="button" name="btsubmit" value="SUBMIT" onClick="goSubmit()">  </td>
           <td> <input type="button" name="btclear" value="CLEAR" onClick="clearFields(window.document)">  </td>
         </tr>
          <tr>
           <td> <input name="sortCriteria" type="hidden"> </td> 
	   <td> <input name="sortCountPrice" type="hidden"> <input name="sortCountOrder" type="hidden"> <input name="sortCountDate" type="hidden"></td>
         </tr>
        </table>
    </form>
   </div>
   <div id="big_stock">
 	<p id="p_big_stock">      </p>
   </div>

</div>

 <div id="stockList_container" style="visibility:hidden">
     <iframe id="stockListResult" name="stocklistframe" src="" height= "400"  width="225" frameborder="0" marginheight="0" marginwidth="5" >
     </iframe>
   </div>
   <script language="Javascript" type="text/javascript">
    if (window.screen.width <= 1024) {
       document.write( '  <div id="query" style="visibility:visible"> ' +
           '<iframe id="queryResult" name="queryframe" height= "650" src="" width="475" frameborder="0" marginheight="0" marginwidth="5" > ' +
        ' </iframe> ' +
      ' </div> ');
        
    } else {
     document.write( '  <div id="query" style="visibility:visible"> ' +
           '<iframe id="queryResult" name="queryframe" height= "650" src="" width="700" frameborder="0" marginheight="0" marginwidth="5" > ' +
       ' </iframe> ' +
     ' </div> ');
   }
   </script>

<!--
   <div id="query" style="visibility:visible">
     <iframe id="queryResult" name="queryframe" height= "650" src="" width="700" frameborder="0" marginheight="0" marginwidth="5" >
     </iframe>
   </div>
-->



 </BODY>
</HTML>
OUT_HTML
	   print $out_buffer;
}


sub display_footer
{

 print;

}





1;
