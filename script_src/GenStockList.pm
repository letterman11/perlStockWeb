package GenStockList;


use strict;
use CGI;
use CGI::Carp;
use DBI;


sub new
{
	my $class = shift;
	my $self = {};
	$self->{STOCKLIST} = shift;

	bless ($self,$class);
	return $self;

}

sub display
{

	my $self = shift;
	my $out_buffer;
	my $rowlen = 5;
	my @stocklist_array = @{$self->{STOCKLIST}};

	my $stock_name = ();
	my $old_stock_name = ();
	my $div_id = ();
	my ($i,$j) = ();
	my ($true,$false) = (1,0);


	my $flag_newdiv= $false;

        @stocklist_array = sort(@stocklist_array);	

	$out_buffer = "<html><head><title> stocklist </title> "
		    . "<script language=\"Javascript\" src=\"/~abrooks/validation.js\" type=\"text/javascript\"> </script> "
		    . "<LINK href='/~abrooks/style.css' rel='stylesheet' type='text/css'> "
		    . "	</head>\n "
		    . "<body> ";

	for($i=0,$j=0; $i< scalar(@stocklist_array); $i++) 
	{

		$stock_name = $stocklist_array[$i];
		if(substr($stock_name,0,1) ne substr($old_stock_name,0,1)) 
		{
			$div_id = "stock_pre" . substr($stock_name,0,1);	
			$out_buffer .= "<div id=\"$div_id\" class=\"stocklist_div\">\n"
				    . "<table class=\"results\" cellspacing=\"1\" cellpadding=\"1\"> "
				    . "<tr class=\"tbl_hd_stock_sym\"><th width=\"100%\"><a class=\"tbl_hd_stock_sym_link\" href=\"javascript:void 0\" onclick=\"giveTop(this)\"> " 
				    . substr($stock_name,0,1) . "</a>" . "</th></tr>\n" 
				    . "<tr class=\"tbl_stock_sym\">";
				   
			for($j=$i; ($j < $i + $rowlen) && ($j < scalar(@stocklist_array)); $j++)
			{ 
				$out_buffer .= "<td> <a href=\"javascript: void 0\" onclick=\"setStockField('$stocklist_array[$j]')\" > $stocklist_array[$j] </a> </td>";
				if(substr($stocklist_array[$j],0,1) ne substr($stocklist_array[$j+1],0,1))
				{
					$i=$j;
					$flag_newdiv = $true;
					last;
				}
			}

			$out_buffer .= "</tr>\n";

		} else { 

			$out_buffer .= "<tr  class=\"tbl_stock_sym\">";

                        for($j=$i; ($j < $i + $rowlen) && ($j < scalar(@stocklist_array)); $j++)
                        {
                                $out_buffer .= "<td> <a href=\"javascript: void 0\" onclick=\"setStockField('$stocklist_array[$j]')\"> $stocklist_array[$j] </a> </td>";
                                if(substr($stocklist_array[$j],0,1) ne substr($stocklist_array[$j+1],0,1))
                                {
                                        $i=$j;
                                        $flag_newdiv = $true;
                                        last;
                                }
                        }

			$out_buffer .= "</tr>\n";

		}

		if($flag_newdiv)
		{
			$out_buffer .= "</table> </div>\n";
			$flag_newdiv = $false;		  
		} 

		$i=$j;
		$old_stock_name = $stocklist_array[$i];
	}	
	
	$out_buffer .= "</body></html>\n";
	print $out_buffer;

}






1;
