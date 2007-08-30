package GenView;

use strict;
use GenReport;
use GenError;
use GenLogin;


my %classHash = (
		#	DATAREF => undef,
			ERRCODE => undef,
			AUTHLIST => undef,
			OBJECT_CALL => undef,
		);

sub new
{
	my $proto = shift;
	my $self = {};
	my $class = ref($proto) || $proto;
	bless ($self,$class);
	return $self;

}

sub stockHeaderHtml
{
	print "\n<tr><th> GenView TA NUMBER </th><th> STOCK SYMBOL</th><th> LIMIT PRICE </th><th> ORDER QUANTITY </th> </tr>\n";

}


sub display
{
	my $self = shift(); 

}










1;
