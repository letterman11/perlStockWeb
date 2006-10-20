package Error;



my %err_codes = ( 
			101 => "Failed Login",
			102 => "Database Failure",
			ERRCOND => undef,
		);	



sub new
{
   my $class = shift;
   my $code  = shift; 
   my $self = \%err_codes;
   ${$self}{$err_codes}{ERRCOND} = $code;
   bless ($self, $class);
   return $self;   

}








1;
