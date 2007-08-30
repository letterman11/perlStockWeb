package GenLogin;

@ISA = qw(GenView);

use strict;
use StockUtil;



sub stockHeaderHtml
{
  print "\n<tr><th> GenLogin TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}

#sub new
#{
#   my $class = shift();
#   my $self = ();
#   @_ ?  $self = shift() : $self =  {};
#   bless ($self,$class);
#}

sub display
{
   my $self = shift(); 
   my $out_buffer = ();

   print StockUtil::headerHtml();
   $out_buffer = <<"OUT_HTML";
<div id="main">
        <div id="banner">
                   <img src="http://192.168.1.104:8080/~abrooks/DCBANNER_CROP2.jpg">
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
        </div>
</div>

OUT_HTML
   print $out_buffer;
   StockUtil::footerHtml();
}
















1;
