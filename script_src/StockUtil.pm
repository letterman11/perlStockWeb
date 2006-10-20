package StockUtil;

use strict;
use CGI::Cookie;


BEGIN
{
     require         Exporter;

     use vars          qw(@ISA @EXPORT @EXPORT_OK);
     @ISA            = qw(Exporter);
     @EXPORT         = qw(&headerHttp &headerHtml &parseParms &printInputEnv &dumpEnvHtml &footerHtml);
     @EXPORT_OK      = qw();

}
 


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
   print"\n</table>"; 
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
  my $id = $cookie_list{'StockApp_ID'}->value;
  my $reqlist = parseParms();

  
  return GenLogin->new() unless (defined $id);
  return Error->new(101) unless (defined $id);
  

}

sub genID()
{



}

1;
