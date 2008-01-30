# INSTANCES AND HASHES MUST MATCH IN NUMBER

 $::SESSION_CONFIG = {
			INSTANCES 	=> [  qw(ses0 ses1 ses2 ses3 ses4 ses5 ses6 ses7 ses8 ses9) ],
			HASHES		=> [ (\%sessionHash0, \%sessionHash1, \%sessionHash2, \%sessionHash3, 
								\%sessionHash4, \%sessionHash5, \%sessionHash6,
								\%sessionHash7, \%sessionHash8, \%sessionHash9) ], 
			SIZE		=> 65001,
			
		    };


#push @::shash, (\%sessionHash0, \%sessionHash1, \%sessionHash2, \%sessionHash3 );

#$::URL_PATHS =  {
#			BANNER_IMAGE		=> "http://www.dcoda.net/DCBANNER_CROP2.jpg",
#			STOCKAPP_HTM		=> "http://www.dcoda.net/stockapp.html",
#			REGISTRATION_HTM	=> "http://www.dcoda.net/registration.html",
#			DIV_REGISTER_FHM        => "/home/u6/octagonyellow/StockApp/web_src/div_register.fhtm"
#			MAINSTYLE_CSS		=> "http://www.dcoda.net/style.css",
#			VALIDATION_JS		=> "http://www.dcoda.net/validation.js"	,
#			COMMON_JS		=> "http://www.dcoda.net/common.js",
#		};


$::URL_PATHS =  {
                       BANNER_IMAGE            => "/~abrooks/DCBANNER_CROP2.jpg",
                       STOCKAPP_HTM            => "/~abrooks/stockapp.html",
                       REGISTRATION_HTM        => "/~abrooks/registration.html",
		       DIV_REGISTER_FHM        => "../web_src/div_register.fhtm",
                       MAINSTYLE_CSS           => "/~abrooks/style.css",
                       VALIDATION_JS           => "/~abrooks/validation.js",
                       COMMON_JS               => "/~abrooks/common.js",
               };

