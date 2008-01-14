#!/usr/bin/perl -wT

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use StockUtil;
use DbConfig;
use CGI qw /:standard/;
use CGI::Carp qw(fatalsToBrowser);
use DBI;

my $query = new CGI;
my $callObj =  StockUtil::formValidation($query);

if (ref $callObj eq 'Error') {
	GenError->new($callObj)->display();
}

my $sqlHash = $callObj;

my $dbconf = DbConfig->new();

#my $insert_sql_str = "INSERT INTO user VALUES ($user_name,$user_name,$password," 
#					. "$first_name,$last_name,$address1,$address2,$zipcode,"
#					. "$phone,$email_address,$state,$city)";

my $insert_sql_str = "INSERT INTO user VALUES ($sqlHash->{userName},$sqlHash->{userName},$sqlHash->{password}," 
					. "$sqlHash->{firstName},$sqlHash->{lastName},$sqlHash->{address1},$sqlHash->{address2},$sqlHash->{zipcode},"
					. "$sqlHash->{phone},$sqlHash->{email},$sqlHash->{state},$sqlHash->{city})";


carp ("$insert_sql_str");

my $dbh = DBI->connect( "dbi:mysql:"
                . $dbconf->dbName() . ":"
                . $dbconf->dbHost(),
                  $dbconf->dbUser(),
                  $dbconf->dbPass(), $::attr )
                or die "Cannot Connect to Database $DBI::errstr\n";


my $sth = $dbh->prepare($insert_sql_str);

carp ("$insert_sql_str");

$sth->execute();
