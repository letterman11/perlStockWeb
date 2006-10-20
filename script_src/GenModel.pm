package GenModel;

use strict;
use DBI;
use DbConfig;


sub new
{
   my $class        = shift;
   my $self         = {}; 
   $self->{PARMS}   = shift();
   bless ($self,$class);
   return $self;
}

sub genSQL
{
   my $self = shift();
   my %requestParms = %{$self->{PARMS}};

   my $sqlStr = "SELECT ta_number, stock_symbol, limit_price, order_quantity from orders WHERE ";
   $sqlStr   .= " stock_symbol = " . "'". $requestParms{stkName} . "'";
   $sqlStr   .= " AND limit_price >= " . $requestParms{minPrice}  if ($requestParms{minPrice} || $requestParms{minPrice} eq 0);
   $sqlStr   .= " AND limit_price <= " . $requestParms{'maxPrice'}  if ($requestParms{'maxPrice'} || $requestParms{'maxPrice'} eq 0);
   $sqlStr   .= " AND order_quantity >= " . $requestParms{'minQty'} if ($requestParms{'minQty'} || $requestParms{'minQty'} eq 0);
   $sqlStr   .= " AND order_quantity <= " . $requestParms{'maxQty'} if ($requestParms{'maxQty'} || $requestParms{'maxQty'} eq 0);
   $self->{SQLSTR} =  $sqlStr;
   print "<!-- $sqlStr -->\n";

}

sub execQuery
{
   my $self     = shift();
   my $dbconf   = DbConfig->new();
   my $dbh	= DBI->connect( "dbi:mysql:" . $dbconf->dbName() . ":" . $dbconf->dbHost(), $dbconf->dbUser(), $dbconf->dbPass() )
   or die "Cannot Connect to Database $DBI::errstr\n";
   my $sth      = $dbh->prepare($self->{SQLSTR}); 
   $sth->execute();
   $self->{DBDATAREF} = $sth->fetchall_arrayref();
#   $sth->dump_results(); 
   $dbh->disconnect()
    or warn "Disconnection failed: $DBI::errstr\n"; 
   return $self->{DBDATAREF};
}












1;
