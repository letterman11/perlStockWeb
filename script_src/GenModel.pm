package GenModel;

use strict;
use DBI;
use GenView;
use DbConfig;
use LOGGER;
use Data::Dumper;
use Benchmark;

sub new
{
	my $class = shift;
	my $self  = {}; 
	$self->{PARMS} = shift;
	$self->{ROWCOUNT} = ();
	bless ($self,$class);
	return $self;
}

sub genSQL
{
	my $self = shift();
	if (ref $_[0] eq 'SessionObject') {
		my $sessObj = shift;
		my %requestParms = %{$self->{PARMS}};
		my $page = defined $requestParms{page} ?  $requestParms{page} : 1 ;
		my $rowsPerPage = $requestParms{'rowsPerPage'} if defined $requestParms{'rowsPerPage'};
		$rowsPerPage = $rowsPerPage || 35;
		$self->{ROWCOUNT} = scalar(@{$sessObj->{DATA}});
		my $data = ();
		my $i = 0;
		my $j = 0;

		my $sqlStr = "SELECT ta_number, stock_symbol, limit_price, order_quantity from orders WHERE  ta_number in ( ";
		my $totRows = scalar(@{$sessObj->{DATA}});

	  	if ($page > 1) {
			$i = --$page * $rowsPerPage;
			$j = ++$page * $rowsPerPage;
			$j = $j > $totRows ? $totRows : $j; 
		} else {
			$i = 0;
			$j = $rowsPerPage;  
		}
		

#		LOGGER::LOG(Dumper($sessObj->{DATA}));
		LOGGER::LOG("$i ########### $j");
				
		$data = ${@{$sessObj->{DATA}}}[$i];
		$sqlStr .= " '$data' ";
		for(++$i; $i < $j; $i++) {
			$data = ${@{$sessObj->{DATA}}}[$i];
			$sqlStr .= ", '$data'"; 
		}

		$sqlStr .= " ) ORDER BY limit_price, order_quantity ";
		$self->{SQLSTR} = $sqlStr;
		LOGGER::LOG ("$self->{SQLSTR} : SESSIONOBJECTSQL");

	} else {
                my %requestParms = %{$self->{PARMS}};

                my $sqlStr = "SELECT ta_number from orders WHERE ";
                $sqlStr   .= " stock_symbol = " . "'". $requestParms{stkName} . "'";
                $sqlStr   .= " AND limit_price >= " . $requestParms{minPrice}  if ($requestParms{minPrice} || $requestParms{minPrice} eq 0);
                $sqlStr   .= " AND limit_price <= " . $requestParms{'maxPrice'}  if ($requestParms{'maxPrice'} || $requestParms{'maxPrice'} eq 0);
                $sqlStr   .= " AND order_quantity >= " . $requestParms{'minQty'} if ($requestParms{'minQty'} || $requestParms{'minQty'} eq 0);
                $sqlStr   .= " AND order_quantity <= " . $requestParms{'maxQty'} if ($requestParms{'maxQty'} || $requestParms{'maxQty'} eq 0);
		$sqlStr   .= " ORDER BY limit_price, order_quantity ";
                $self->{SQLSTR} =  $sqlStr;

		LOGGER::LOG ("$self->{SQLSTR} : PARAMETERSQL");
	}
 
}

sub execIndexQuery
{
	my $self = shift();
	my $dbconf = DbConfig->new();
	my $dbh	= DBI->connect( "dbi:mysql:" . $dbconf->dbName() . ":" 
			. $dbconf->dbHost(), $dbconf->dbUser(), $dbconf->dbPass() )
				or die "Cannot Connect to Database $DBI::errstr\n";

	my $sth = $dbh->prepare($self->{SQLSTR}); 
	LOGGER::LOG("$self->{SQLSTR} : EXECINDEXQUERY" );

        my $time00 = new Benchmark;
	$sth->execute();
	$self->{DATAREF} = $sth->fetchall_arrayref();
        my $time11 = new Benchmark;
        my $timedd = timediff($time11, $time00);
        my $tstr =  timestr($timedd);
        LOGGER::LOG(" ====================");
        LOGGER::LOG(" ======== Timer: $tstr ======");
        LOGGER::LOG(" =====================");

	$self->{ROWCOUNT} = $sth->rows;

	$dbh->disconnect()
			or warn "Disconnection failed: $DBI::errstr\n"; 

	my @data = ();

	foreach my $row (@{$self->{DATAREF}}) {
		push @data, @$row;  
	}
	
	return(\@data,$self->{ROWCOUNT});
}

sub execQuery
{
        my $self = shift();
        my $dbconf = DbConfig->new();
        my $dbh = DBI->connect( "dbi:mysql:" . $dbconf->dbName() . ":"
                . $dbconf->dbHost(), $dbconf->dbUser(), $dbconf->dbPass() )
                or die "Cannot Connect to Database $DBI::errstr\n";
        my $sth = $dbh->prepare($self->{SQLSTR});
	LOGGER::LOG("$self->{SQLSTR} : EXECQUERY" );
        $sth->execute();
        $self->{DATAREF} = $sth->fetchall_arrayref();
	$self->{ROWCOUNT2} = $sth->rows;
        #   $sth->dump_results();
        $dbh->disconnect()
                or warn "Disconnection failed: $DBI::errstr\n";
        return $self->{DATAREF};
}


1;
