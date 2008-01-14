package StockUtil;

use strict;
use Error;
use GenReport;
use GenError;
use GenLogin;
use SessionObject;
use CGI::Cookie;
use Storable;
use Data::Dumper;
require Session::Client;
require '../cgi-bin/config.pl'; # temporary will go away

BEGIN
{
     require         Exporter;

     use vars          qw(@ISA @EXPORT @EXPORT_OK);
     @ISA            = qw(Exporter);
     @EXPORT         = qw(&headerHttp &headerHtml &footerHtml &validateSession &storeSession &genID);
     @EXPORT_OK      = qw();
}
 
my $true	     = 1;
my $false	     = 0;


sub headerHttp
{
	return "Content-type:text/html\n\n";
}


sub headerHtml
{
	my $buffer_out;
	$buffer_out = headerHttp();
	$buffer_out .= "<html>\n"
   	       .  " <head>\n"
    	       .  "<title> StockApp</title>\n"
 	       .  "<LINK href='/~abrooks/style.css' rel='stylesheet' type='text/css'>\n"
	       .  "</head>\n"
	       .  "<body>\n";
	return $buffer_out;

}


sub footerHtml
{
	my $buffer_out;
	$buffer_out = "</body>\n"
		. "</html>\n";
	return $buffer_out;
}


sub dumpEnvHtml
{
	my %anyHash		= %ENV;
	my ($key,$value)	= ""; 
	print "\n<table>";
	while (($key,$value) = each %anyHash) {
		print "\n<tr><td bgcolor=\"lightblue\"> $key </td> <td bgcolor=\"cyan\">$value</td></tr>";
	} 
	print "\n</table>"; 
}

sub parseParms
{
	my $rawInputParms	= $ENV{QUERY_STRING};
	my %inputHash	= ();

	my @rawInputParms = split /&/, $rawInputParms;
	foreach my $rawStr (@rawInputParms) {
		my ($key,$value) = split /=/, $rawStr;
		$inputHash{$key} = $value;
	}
	return \%inputHash;

}

sub printInputEnv 
{
	my ($key,$value)	= ""; 
	while (($key,$value) = each my %inputHash) {
		print "$key=$value\n";
	} 
  
}

sub genSessionID
{
	my @id_list = qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9);
	my $id;
	for(my $i = 0; $i < 16; $i++) {
		 $id .= $id_list[int(rand 35)] ;
	}
	return $id;
}


sub genQueryID
{
        my @id_list = qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9);
        my $id;
        for(my $i = 0; $i < 5; $i++) {
                 $id .= $id_list[int(rand 35)] ;
        }
        return $id;
}



sub storeSession
{
	my $sessionInstance = shift;
	my $sessionID = shift;
	my $userID = shift;
	my $sessionObject = SessionObject->new($sessionInstance,
                                         $sessionID,
                                         (),
                                         ());

	store $sessionObject, "/tmp/$sessionID" || die $!;

}

sub getSessionInstance
{
	my $sInstancePre = 'ses';
	my @numInstances = @{$::SESSION_CONFIG->{INSTANCES}};
	return $sInstancePre . int(rand(scalar(@numInstances)));

}

sub storeSessionObject
{
        my $sessionObject = shift;
        my $sessionFile = $sessionObject->{SESSIONID};
	store $sessionObject, "/tmp/$sessionFile" || die $!;

}

sub validateSession
{
        my ($sessionID,$userID)  = ();

        my %cookies = fetch CGI::Cookie;
        return $false unless (defined $cookies{'stock_SessionID'} && defined $cookies{'stock_UserID'});

        $sessionID = $cookies{'stock_SessionID'}->value;
        $userID = $cookies{'stock_UserID'}->value;

	return Error->new(103) 	if not -e "/tmp/$sessionID";

	my $sessionObject = retrieve("/tmp/$sessionID") || return Error->new(103);

        return $sessionObject;

}

sub formValidation
{
	my $query = shift;
	my %sqlInsert = ();
	my $passLen = 6;
	my $userLen = 6;
	my $emailValRegex = "\w{1}[\w\.]+?\.{1}\w{1}@\w{1}[\w\.]+?\.{1}\w{1}";

	$sqlInsert{firstName} =	isset($query->param('firstName')) ? $query->param('firstName') : 'NULL';
	$sqlInsert{lastName} =	isset($query->param('lastName')) ? $query->param('lastName') : 'NULL';
	$sqlInsert{address1} =	isset($query->param('address1')) ? $query->param('address1') : 'NULL';
	$sqlInsert{address2} =	isset($query->param('address2')) ? $query->param('address2') : 'NULL';
	$sqlInsert{city} =	isset($query->param('city')) ? $query->param('city') : 'NULL';
	$sqlInsert{state} =	isset($query->param('state')) ? $query->param('state') : 'NULL';
	$sqlInsert{zipcode} =	isset($query->param('zipcode')) ? $query->param('zipcode') : 'NULL';
	$sqlInsert{phone} =	isset($query->param('phone')) ? $query->param('phone') : 'NULL';
	$sqlInsert{email} =	isset($query->param('email')) ? $query->param('email') : 'NULL';
	$sqlInsert{userName} =	isset($query->param('userName')) ? $query->param('userName') : 'NULL';
	$sqlInsert{password} =	isset($query->param('password')) ? $query->param('password') : 'NULL';

	return Error->new(108) if($sqlInsert{email} eq 'NULL' || $sqlInsert{userName} eq 'NULL' || $sqlInsert{password} eq 'NULL')

	return Error->new(109) if($sqlInsert{email} !~ /\w+[\w.]+?\w+@\w+[\w.]+?\.\w+\s*$/);

	return Error->new(110) if($sqlInsert{userName} eq 'NULL' || length($sqlInsert{userName}) < $userLen); 

	return Error->new(111) if($sqlInsert{password} eq 'NULL' || length($sqlInsert{password}) < $passLen); 

	return \%sqlInsert;
}

sub isset
{
  return (!((not defined $_[0]) && ($_[0] =~ /^\s*$/)));
}


1;
