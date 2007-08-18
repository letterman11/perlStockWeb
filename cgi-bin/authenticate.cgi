#!/usr/bin/perl -Tw

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use StockUtil;
use Error;
use DbConfig;
use CGI qw /:standard/;
use CGI::Cookie;


my ($userID,$userName,$userPass) = (0,1,2);

my $dbconf = DbConfig->new();
my $dbh = DBI->connect( "dbi:mysql:" . $dbconf->dbName() . ":"
       . $dbconf->dbHost(), $dbconf->dbUser(), $dbconf->dbPass() )
        or die "Cannot Connect to Database $DBI::errstr\n";

my %cookies = fetch CGI::Cookie;

my %form = ();
foreach my $p (param()) {
       $form{$p} = param($p);
}
my ($user_name,$user_pass) = ($form{userName},$form{userPass});

my $sqlstr = "select USER_ID, USER_NAME, USER_PASSWD from USER "
	   . "where USER_NAME = " . $user_name
	   . " and  USER_PASS = " . $user_pass;
  
my $sth = $dbh->prepare($sqlstr);
$sth->execute();

my @user_row = $sth->fetchrow_array();
$sth->finish();
$dbh->disconnect();

if (not defined ($user_row[1])) {
   GenLogin->new()->display();	
} else
{
   my $stockSessionID = StockUtil::genID();
   $cookie1 = new CGI::Cookie(-name=>'stock_SessionID',-value=>$stockSessionID);
   StockUtil::storeSessionID($stockSessionID, $user_row[$userName]);
   $cookie1->bake;
   open(FH, "<$startpage") or warn "Cannot open $startpage\n";
   my $terminator = $/
   undef $/;
   my $out_page = <FH>; #slurp file all at once via above line.
   $/ = $terminator;
   print $out_page, "\n";
   close(FH);

}

