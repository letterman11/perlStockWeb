package GenLogin;

use strict;
use StockUtil;

@GenLogin::ISA = qw(GenView);

sub new
{
   my $class = shift();
   my $self = ();
   @_ ?  $self = shift() : $self =  {};
   bless ($self,$class);

}

sub stockHeaderHtml
{
  print "\n<tr><th> GenLogin TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}

sub display
{
   my $self = shift(); 
   headerHtml();
   stockHeaderHtml
   footerHtml();
}
















1;
