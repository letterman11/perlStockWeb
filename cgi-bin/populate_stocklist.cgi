#!/usr/bin/perl -wT

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use GenStatus;
use GenError;
use Error;
use GenStockList;
use DbConfig;
use CGI qw /:standard/;
use CGI::Carp qw(fatalsToBrowser);
use DBI;
require '/home/abrooks/www/StockApp/cgi-bin/config.pl';

my $stocklist = ();
my @stocklist_array;
my $query = new CGI;

 
my $dbconf = DbConfig->new();

my $select_sql_str = "SELECT DISTINCT stock_symbol FROM orders"; 
carp ("$select_sql_str");

my $dbh = DBI->connect( "dbi:mysql:"
                . $dbconf->dbName() . ":"
                . $dbconf->dbHost(),
                  $dbconf->dbUser(),
                  $dbconf->dbPass(), $::attr )
		  or GenError->new(Error->new(102))->display() and die;;
               
eval {

	my $sth = $dbh->prepare($select_sql_str);

	$sth->execute();

	while( ($stocklist) = $sth->fetchrow_array ) {
		push @stocklist_array, $stocklist;

	}

	$sth->finish();

	$dbh->disconnect();

};

	GenError->new(Error->new(102))->display("Application Error occurred try again later\n") and die "$@" if ($@);

	carp ("@stocklist_array");
	print header;
	GenStockList->new(\@stocklist_array)->display();



exit;

