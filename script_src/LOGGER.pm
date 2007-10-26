package LOGGER;


use strict;



BEGIN
{
     require         Exporter;
 
     use vars          qw(@ISA @EXPORT @EXPORT_OK);
     @ISA            = qw(Exporter);
     @EXPORT         = qw();
     @EXPORT_OK      = qw();
     open (LOGGER, ">>/tmp/LOGGER.out") or die "$!  Cannot open log file\n";
}

sub LOG
{
	my $text = shift;
	
	print LOGGER `date`, " ", $text, "\n";

}


1;
