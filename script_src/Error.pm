package Error;

use strict;

my $true             = 1;
my $false            = 0;


my %err_codes = ( 
			101 => "Failed Login",
			102 => "Database Failure",
			103 => "Session Exists",
			104 => "No Session Exists for ID",
			105 => "No Object exists for Session",
			ERRCOND => undef,
		);	



sub new
{
	my $class = shift;
	my $code  = shift; 
	my $self = \%err_codes;
	$self->{ERRCOND} = $code;
	bless ($self, $class);
	return $self;   

}


sub errText
{
	my $self = shift;
	return $self->{$self->{ERRCOND}};
}





1;
