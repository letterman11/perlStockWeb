package StockUtil;

use strict;
use CGI::Cookie;


BEGIN
{
     require         Exporter;

     use vars          qw(@ISA @EXPORT @EXPORT_OK);
     @ISA            = qw(Exporter);
     @EXPORT         = qw(&headerHttp &headerHtml &validateSession &storeSession &genID);
     @EXPORT_OK      = qw();
}
 
my $true	     = 1;
my $false	     = 0;


sub headerHttp
{
	print "Content-type:text/html\n\n";
}


sub headerHtml
{
print <<headerHTML;
<html>
<head>
<title>Angus Test Pages</title>
<link href="http://192.168.1.101:8080/~abrooks/style.css" rel="stylesheet" type="text/css">
</head>
<body>
headerHTML

}


sub footerHtml
{
print <<footerHTML;
</body>
</html>
footerHTML

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


sub authenticate()
{
	my %cookie_list =  fetch CGI::Cookie;
	return GenLogin->new() unless (defined($cookie_list{StockApp_ID}));

	my $id = $cookie_list{'StockApp_ID'}->value;
	my $reqlist = parseParms();
  
	return GenLogin->new() unless (defined $id);
	return Error->new(101) unless (defined $id);
}

sub genID
{
	my @id_list = qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9);
	my $id;
	for(my $i = 12; $i > 0; $i--) {
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


   open(FH, "$sessionFile") or warn "Cannot open: $sessionFile\n";
   while (<FH>) {
      next if /^#*\s*\t*$/; 
      my ($sessID,$id) = split /\|/;     
      $sessionHash{$sessID}=$id; 
   }      

   if(defined($sessionHash{$sessionID})) {
      close FH; 
      GenError->new()->display();
   } else
   {
      close FH;
      open (FH, ">>$sessionFile") or warn "Cannot open $sessionFile\n";
      print FH "$sessionID|$userID\n";
      close FH;
 
   }

}

sub validateSession
{
   my ($sessionID,$userID)  = @_;

   if ((not defined $sessionID) || (not defined $userID)) {
     my %cookies = fetch CGI::Cookie;
      $sessionID = $cookies{stock_sessionID};
      $userID = $cookies{userID};
   }
   return $false unless (defined $sessionID && defined $userID);   

   my $sessionFile = "/tmp/stockAppSessions.dat";
   my %sessionHash = ();

   open(FH, "$sessionFile") or warn "Cannot open: $sessionFile\n";
   while (<FH>) {
      next if /^#*\s*\t*$/;
      my ($sessID,$id) = split /\|/;
      return $true if $sessionID == $sessID && $userID == $id; 
      #$sessionHash{$sessID}=$id;
   }
   return $false;


}
1;
