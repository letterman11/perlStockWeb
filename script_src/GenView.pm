package GenView;

use strict;


my %classHash = (
			DATAREF  => undef,
			ROWCOUNT => undef, 
			ERRCODE  => undef,
		);

sub new
{
	my $proto = shift;
	my $self = \%classHash;
	my $class = ref($proto) || $proto;
	$self->{DATAREF} = shift;
	$self->{ROWCOUNT} = shift;
	$self->{ERRCODE} = shift if defined(@_);	
	bless ($self,$class);
	return $self;

}












1;
