#!/usr/bin/perl -Tw

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use StockUtil;
use GenModel;
use GenView;
use Error;


headerHttp();

my $auth_state = StockUtil::authenticate();
#my $auth_state = StockUtil::parseParms();

#if (defined($auth_state) && not ref($auth_state) eq 'Error') {
if (ref($auth_state) ne 'Error' &&  ref($auth_state) ne 'GenLogin' && defined($auth_state) ) {
	my $model = GenModel->new($auth_state);
	$model->genSQL();
	$model->execQuery();
	my $view = GenView->new($model);
	$view->display();
} else {
	# in error state send back Error/Login page
	my $view = GenView->new($auth_state);
 	$view->display();
}



