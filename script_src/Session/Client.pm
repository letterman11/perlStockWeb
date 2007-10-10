package Session::Client;

use strict;
#use lib "/home/abrooks/www/StockApp/script_src"; # temporary use...will go away
use lib "../../script_src"; # temporary use...will go away
use IPC::Shareable;
use Error;


my $glue='sess';
my %default_options = (
     create    => 0,
     exclusive => 0,
     mode      => 0666,
     destroy   => 0,
     );

my %sessionHash = ();

sub new
{
	my $class = shift; 
	my $self = \%sessionHash; 
	
	#%default_options = %{shift()} if defined(@_);	
		
	tie %sessionHash, 'IPC::Shareable', $glue, { %default_options } or
     	die "client: tie failed\n";
		
	bless $self, $class;
	return $self;	

}

sub setSessionID
{
	my $self = shift;
	my $sessID = shift;
	my $userID = shift;

	$self->{$sessID} = {};
	$self->{$sessID}->{userID} = $userID;

}

sub validateSessionID
{
	my $self = shift;
	my $sessID = shift;

	return $true if exists $self->{$sessID}; 
	return Error->new(106);

}

sub getSessionObject
{
        my $self = shift();
        my $sessionID = shift();
        return Error->new(105) unless exists $self->{$sessionID}
                        and exists $self->{$sessionID}->{OBJECTREF};
        return $self->{$sessionID}->{OBJECTREF};

}


sub setQueryID
{
	my $self = shift;
	my ($sessID,$qID) = @_;
	
	return Error->new(106) unless defined $sessID and defined $qID;
	
	$self->{$sessID}->{queryID} = $qID;
}

sub getQueryID
{
        my $self = shift;
        my $sessID = shift;

        return Error->new(107) unless defined($self->{$sessID}->{queryID});
        return $self->{$sessID}->{queryID};

}


sub isset
{ return (defined($_[0]) && ($_[0] !~ /^\s*$/)); }


1;
