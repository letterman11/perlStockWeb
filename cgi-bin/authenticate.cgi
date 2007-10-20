#!/usr/bin/perl -w

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use GenView;
use GenReport;
use StockUtil;
use DbConfig;
use CGI qw /:standard/;
use CGI::Cookie;
use CGI::Carp qw(fatalsToBrowser);
use DBI;

my $userID = 0;
my $userName = 1;
my $userPass = 2;
my $startpage="/home/abrooks/www/StockApp/web_src/StockApp.html";
my $query = new CGI;


my $dbconf = DbConfig->new();
my $dbh = DBI->connect( "dbi:mysql:"  
		. $dbconf->dbName() . ":"
		. $dbconf->dbHost(), 
		$dbconf->dbUser(), 
		$dbconf->dbPass() )
        	or die "Cannot Connect to Database $DBI::errstr\n";

my $user_name = $query->param('userName');
my $user_pass = $query->param('userPass');

my $sqlstr = "select USER_ID, USER_NAME, USER_PASSWD from user "
		. " where USER_NAME = '" 
		. $user_name . "' and  USER_PASSWD = '" . $user_pass .  "'";
  
my $sth = $dbh->prepare($sqlstr);
$sth->execute();

my @user_row = $sth->fetchrow_array();
$sth->finish();

$dbh->disconnect();

if (not defined ($user_row[1])) {
   GenLogin->new()->display();	
} else
{
   my $stockSessionID = StockUtil::genSessionID();

   my $sessionInstance = StockUtil::getSessionInstance();

   my $c1 = new CGI::Cookie(-name=>'stock_SessionID',
			-value=>$stockSessionID,
			-path=>'/');

   my $c2 = new CGI::Cookie(-name=>'stock_UserID',
			-value=>$user_name,
			-path=>'/');

   my $c3 = new CGI::Cookie(-name=>'Instance',
			-value=>$sessionInstance,
			-path=>'/');

   print "Set-Cookie: $c1\n";
   print "Set-Cookie: $c2\n";
   print "Set-Cookie: $c3\n";

   StockUtil::storeSession2($sessionInstance,
				$stockSessionID, 
				$user_row[$userName]);

   open(FH, "<$startpage") or 
		warn "Cannot open $startpage\n";
   my $terminator = $/;
   undef $/;
   my $out_page = <FH>; #slurp file all at once via above line.
   $/ = $terminator;
   close(FH);

   print header;
   print $out_page, "\n";

}

