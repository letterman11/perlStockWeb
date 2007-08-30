package GenReport;

@GenReport::ISA = qw(GenView);

use strict;


sub stockHeaderHtml
{
	return "<tr class='tbl_hd'><th> TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}


sub new
{
	my $class = shift();
	my $self = ();
	@_ ?  $self = shift() : $self =  {};
	bless ($self,$class);
}



sub display
{
	my $self = shift(); 
	my $dModel = shift();
	my $buffer_out = ();
   
	$buffer_out  = StockUtil::headerHtml();
	$buffer_out .= "<table class='results' width=65%  cellspacing='1' cellpadding='1' border='0' align='left' >\n";
	$buffer_out .= stockHeaderHtml();
	my  ($i,$alt) = 0;
	foreach my $row (@{$dModel->{DATAREF}}) {
		my ($ta_number, $stock_symbol, $limit_price, $order_quantity) = @$row;
		$alt =  (++$i % 2 ? 1 : 2);
		$buffer_out .= "<tr class='tbl_num$alt'><td class='tbl_txt'> $ta_number </td> "  
	 	            .  "<td class='tbl_txt' width=25%> $stock_symbol</td><td> $limit_price </td><td> $order_quantity</td></tr>\n";

	} 
	$buffer_out .= "\n</table>\n";
	$buffer_out .= StockUtil::footerHtml();
	print $buffer_out;
}




1;
