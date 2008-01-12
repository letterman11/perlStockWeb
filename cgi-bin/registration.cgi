#!/usr/bin/perl -wT

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use StockUtil;
use DbConfig;
use CGI qw /:standard/;
use CGI::Carp qw(fatalsToBrowser);
use DBI;

my $query = new CGI;

my $first_name = $query->param('firstName');
my $last_name = $query->param('lastName');
my $address1 = $query->param('address1');
my $address2 = $query->param('address2');
my $city = $query->param('city');
my $state = $query->param('state');
my $zipcode = $query->param('zipcode');
my $phone = $query->param('phone');
my $email_address = $query->param('email');
my $user_name = $query->param('userName');
my $password = $query->param('password');

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#
#===== Perform validation =======#

my $dbconf = DbConfig->new();

my $insert_sql_str = "INSERT INTO user VALUES ($user_name,$user_name,$password," 
					. "$first_name,$last_name,$address1,$address2,$zipcode,"
					. "$phone,$email_address,$state,$city)";
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
