# INSTANCES AND HASHES MUST MATCH IN NUMBER

 $::SESSION_CONFIG = {
			INSTANCES 	=> [  qw(ses0 ses1 ses2 ses3 ses4 ses5 ses6 ses7 ses8 ses9) ],
			HASHES		=> [ (\%sessionHash0, \%sessionHash1, \%sessionHash2, \%sessionHash3, 
								\%sessionHash4, \%sessionHash5, \%sessionHash6,
								\%sessionHash7, \%sessionHash8, \%sessionHash9) ], 
			SIZE		=> 65001,
			
		    };


#push @::shash, (\%sessionHash0, \%sessionHash1, \%sessionHash2, \%sessionHash3 );
