package GenView;

use strict;
use StockUtil;


sub new
{
   my $class = shift();
   my $self = shift();
   bless ($self,$class);

}

sub stockHeaderHtml
{
  print "\n<tr><th> TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}

sub display
{
   my $self = shift(); 
   headerHtml();
   print "\n<table width=100% border=2 align=center>\n";
   stockHeaderHtml();
   foreach my $row (@{$self->{DBDATAREF}}) {
     my ($ta_number, $stock_symbol, $limit_price, $order_quantity) = @$row;
     print "<tr><td> $ta_number </td><td width=25%> $stock_symbol</td><td> $limit_price </td><td> $order_quantity</td></tr>\n";

  } 
  print"\n</table>\n";
  footerHtml();
}
















1;
