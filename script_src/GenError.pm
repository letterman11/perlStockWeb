package GenError;

@ISA = qw(GenView);

use strict;
use StockUtil;



sub stockHeaderHtml
{
  print "\n<tr><th> GenLogin TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}

sub display
{
   my $self = shift(); 
   my $errstr = shift if @_;
   
   my $out_buffer = ();

   print StockUtil::headerHtml();
   $out_buffer = <<"OUT_HTML";
<div id="main">
        <div id="banner">
                   <img src="/~abrooks/DCBANNER_CROP2.jpg">
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
              </table>
          </form>
	<span class="errtext"> <p> $errstr </p> </span>
        </div>
</div>

OUT_HTML
   print $out_buffer;
   StockUtil::footerHtml();
}
















1;
