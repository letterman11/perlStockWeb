package GenReport;

use strict;
use StockUtil;

@GenReport::ISA = qw(GenView);


sub stockHeaderHtml
{
  print "\n<tr class='tbl_hd'><th> TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}

sub display
{
   my $self = shift(); 
   headerHtml();
   print "\n<table class='results' width=65%  cellspacing='1' cellpadding='1' border='0' align='left' >\n";
   stockHeaderHtml();
   my  ($i,$alt) = 0;
   foreach my $row (@{$self->{DATAREF}{DBDATAREF}}) {
     my ($ta_number, $stock_symbol, $limit_price, $order_quantity) = @$row;
     $alt =  (++$i % 2 ? 1 : 2);
     print "<tr class='tbl_num$alt'><td class='tbl_bld'> $ta_number </td><td width=25%> $stock_symbol</td><td> $limit_price </td><td> $order_quantity</td></tr>\n";

  } 
  print"\n</table>\n";
  footerHtml();
}
















1;
