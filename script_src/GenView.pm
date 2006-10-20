package GenView;

use strict;
use StockUtil;
use GenReport;
use GenError;
use GenLogin;


my %classHash = (
			DATAREF => undef,
			ERRCODE => undef,
			AUTHLIST => undef,
			OBJECT_CALL => undef,
		);

sub new
{
   my $proto = shift;
   my $class = ref($proto) || $proto;

   if(@_) {
     $classHash{OBJECT_CALL} = ref($_[0]);
     $classHash{DATAREF} = shift if ref($_[0]) eq 'GenModel';
     $classHash{ERRCODE} = shift if ref($_[0]) eq 'Error';
     $classHash{AUTHLIST} = shift if ref($_[0]) eq 'GenLogin';
   }

   my $self = \%classHash;
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
   GenReport->new()->display() if $self->{OBJECT_CALL} eq 'GenModel';
   GenError->new()->display() if $self->{OBJECT_CALL} eq 'Error';
   GenLogin->new()->display() if $self->{OBJECT_CALL} eq 'GenLogin';

}














1;
