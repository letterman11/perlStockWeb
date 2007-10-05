package Session::Client

use strict;
use IPC::Shareable;
use Session::Server;


my $glue='sess';
my %default_options = (
     create    => 0,
     exclusive => 0,
     mode      => 0644,
     destroy   => 0,
     );

my %sessionHash = ();

sub new
{
	my $class = shift; 
	my $self = \%sessionHash; 
	
	%default_options = shift if defined(@_);	
		
	tie %sessionHash, 'IPC::Shareable', $glue, { %default_options } or
     	die "client: tie failed\n";
		
	bless $self, $class;
	return $self;	

}

sub getSessionObject
{
	my $self = shift();
	my $sessionID = shift();
	return undef unless exists $self->{$sessionID} 
			and exists $self->{$sessionID}->{OBJECTREF};
	return $self->{$sessionID}->{OBJECTREF};	

}

sub getQueryID
{
	my $self = shift;
	my ($sessID,$qID) = @_ unless scalar @_ < 2;
	
}


sub setSessionID
{
	my $self = shift;
	my $sessID = shift;

	$self->{$sessID};

}


sub setQueryID
{
	my $self = shift;
	my ($sessID,$qID) = @_ unless scalar @_ < 2;
	
	if (not defined $self->{$sessID}->{QueryID}) {
		$self->{$sessID

	}
	else
	{

	}
	
	$self->{$sessID}->{QueryID} = $qID;
}




1;
