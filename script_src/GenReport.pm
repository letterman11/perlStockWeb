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
	my $self = {};
	my $mModel = shift;
	$self->{DATA} = $mModel->{DATAREF}; 
	$self->{ROWCOUNT} = $mModel->{ROWCOUNT};
	$self->{ROWSPERPAGE} = $mModel->{PARMS}->{rowsPerPage} || 35;	
	bless ($self,$class);
}



sub display
{
	my $self = shift(); 
	my $buffer_out = ();
   
	$buffer_out  = StockUtil::headerHtml();
	$buffer_out .= "<table class='results' width=65%  cellspacing='1' cellpadding='1' border='0' align='left' >\n";
	$buffer_out .= stockHeaderHtml();
	my  ($i,$alt) = 0;
	foreach my $row (@{$self->{DATA}}) {
		my ($ta_number, $stock_symbol, $limit_price, $order_quantity) = @$row;
		$alt =  (++$i % 2 ? 1 : 2);
		$buffer_out .= "<tr class='tbl_num$alt'><td class='tbl_txt'> $ta_number </td> "  
	 	            .  "<td class='tbl_txt' width=25%> $stock_symbol</td><td> $limit_price </td><td> $order_quantity</td></tr>\n";

	} 
	$buffer_out .= "\n</table>\n";
	$buffer_out .= "<!-- " . $self->{ROWCOUNT} . " -->"; 
	
	$buffer_out .= StockUtil::footerHtml();
	print $buffer_out;
}

sub display2
{
	my $self = shift(); 
	my $buffer_out = ();
   
	$buffer_out  = StockUtil::headerHtml();
	$buffer_out .= "<table class='results' width=65%  cellspacing='1' cellpadding='1' border='0' align='left' >\n";
	$buffer_out .= stockHeaderHtml();
	my  ($i,$alt) = 0;
	foreach my $row (@{$self->{DATA}}) {
		my ($ta_number, $stock_symbol, $limit_price, $order_quantity) = @$row;
		$alt =  (++$i % 2 ? 1 : 2);
		$buffer_out .= "<tr class='tbl_num$alt'><td class='tbl_txt'> $ta_number </td> "  
	 	            .  "<td class='tbl_txt' width=25%> $stock_symbol</td><td> $limit_price </td><td> $order_quantity</td></tr>\n";

	} 
	$buffer_out .= "<tr><td colspan='100%'>";
	$buffer_out .= $self->genNavigation();
	$buffer_out .= "\n </td></tr>\n";
	$buffer_out .= "\n</table>\n";
	$buffer_out .= "<!-- " . $self->{ROWCOUNT} . " -->"; 

	$buffer_out .= StockUtil::footerHtml();
	print $buffer_out;
}


sub genNavigation
{
	my $self = shift;
	my $buffer_out = (); 
	my $pgCnt = 1;
	my $currCnt  = 0;
	my $totRows = $self->{ROWCOUNT};
	my $rowsPerPage = $self->{ROWSPERPAGE};

	if($totRows > $rowsPerPage) {
		$buffer_out .= "Page(s) ";
		do {
			$buffer_out .= " <A HREF=/cgi-bin/stockReportDetail.cgi?page=" . $pgCnt .  "&rowsPerPage=" . $rowsPerPage . ">" .  $pgCnt . "</A> ";
			$currCnt += $rowsPerPage;
			$pgCnt++;
		}while($currCnt < $totRows);
	}
	return $buffer_out;

}


1;
