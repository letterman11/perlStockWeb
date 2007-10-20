#!/usr/bin/perl -Tw

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use GenView;
use StockUtil;
use GenModel;
use Error;
use CGI qw (:standard);
use CGI::Carp qw(fatalsToBrowser);


my $query = new CGI;
my %params = $query->Vars;

if(StockUtil::validateSession2()) {

   my $model = GenModel->new(\%params);
   $model->genSQL();
   $model->execQuery();
   my $view = GenReport->new();
   $view->display($model);

} else {

   GenLogin->new()->display();

}

