package GenError;


use strict;
use StockUtil;


sub new
{
        my $class = shift();
        my $self = {};
	$self->{ERROBJ} = shift if @_;
        bless ($self,$class);
	return $self;
}

sub display
{
   my $self = shift(); 
   my $errstr = shift if @_;
   my $out_buffer = ();
 
   $errstr = exists($self->{ERROBJ}) && $self->{ERROBJ}->errText ? $self->{ERROBJ}->errText : $errstr;


   print StockUtil::headerHtml();
   $out_buffer = <<"OUT_HTML";
<div id="main">
        <div id="banner">
                 <a  href="$::URL_PATHS->{REGISTRATION_HTM}">  <img id="banner_image" src="$::URL_PATHS->{BANNER_IMAGE}"> </a>
        </div>
</div>

<div id="app_error">
	<span class="errtext_large"> <p> $errstr </p> </span>
</div>

</body>
</html>
OUT_HTML
   print $out_buffer;
   StockUtil::footerHtml();
}










1;
