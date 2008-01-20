package GenView;

use strict;


sub new
{
	my $class = shift;
	my $self = {};
	bless ($self,$class);
	return $self;

}


sub display_header
{
	my $out_buffer=();

	$out_buffer = <<"OUT_HTML";
<div id="main">
        <div id="banner">
         <a class="nolinkstyle" href="/~abrooks/StockApp.html">    <img src="/~abrooks/DCBANNER_CROP2.jpg">  </a>
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
                  <td> Not Registered?   Register <a href="/~abrooks/registration.html"> here </a> </td>
              </tr>
              </table>
          </form>
        </div>

        <div id="logged_on" style="visibility:hidden">
         <span class="form_login">
           <script language="Javascript" type="text/javascript">
             stock_UserID = getCookie('stock_UserID');
             if(stock_UserID != null && stock_UserID.length > 0) {
                document.write(stock_UserID + " LOGGED IN | ");
             }
           </script>
           <a href="/~abrooks/StockApp.html" onclick="logOut('stock_UserID','stock_SessionID','Instance')" target="_top" > LOG OUT </a>
            | <a href="/cgi-bin/profile_page.cgi?'userName'=stock_UserID"> update profile </a>
         </span>
        </div>
</div>
OUT_HTML
	   print $out_buffer;
}


sub display_footer
{

 print;

}





1;
