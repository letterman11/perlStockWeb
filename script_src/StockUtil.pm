package StockUtil;

use strict;
use GenReport;
use GenError;
use GenLogin;
use CGI::Cookie;


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
 	       .  "<LINK href='http://192.168.1.104:8080/~abrooks/style.css' rel='stylesheet' type='text/css'>\n"
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

sub dumpEnv 
{
	my %envHash		= %{shift()};
	my ($key,$value)	= ""; 
	while (($key,$value) = each %envHash) {
		 print "$key=$value\n";
	} 
  
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
	for(my $i = 16; $i > 0; $i--) {
		 $id .= $id_list[int(rand 35)] ;
	}
	return $id;
}

sub storeSession
{
	my $sessionID = shift;
	my $userID = shift;
	my $sessionFile = "/tmp/stockAppSessions.dat";
	my %sessionHash = ();


	open(RFH, "<$sessionFile") or warn "Cannot open (storeSession): $sessionFile\n";
	while (<RFH>) {
		next if /^#*\s*\t*$/; 
		my ($sessID,$id) = split /\|/;     
		$sessionHash{$sessID}=$id; 
	}      

	if(defined($sessionHash{$sessionID})) {
		close RFH; 
		GenError->new()->display();
	} else
	{
		close RFH;
		open (WFH, ">>$sessionFile") or warn "Cannot open $sessionFile\n";
		print WFH "$sessionID|$userID\n";
		close WFH;
 
	}

}

sub validateSession
{
	my ($sessionID,$userID)  = ();

	my %cookies = fetch CGI::Cookie;
	return $false unless (defined $cookies{'stock_SessionID'} && defined $cookies{'stock_UserID'});   

	$sessionID = $cookies{'stock_SessionID'}->value;
	$userID = $cookies{'stock_UserID'}->value;

	my $sessionFile = "/tmp/stockAppSessions.dat";
	my %sessionHash = ();

	open(FH, "<$sessionFile") or warn "Cannot open (validate): $sessionFile\n";
	while (<FH>) {
		next if /^#*\s*\t*$/;
		my ($sessID,$id) = split /\|/;
		chomp($sessID,$id);
		return $true if (($sessionID eq $sessID) && ($userID eq $id)); 
	}
	close FH;
   
	return $false;


}

1;
