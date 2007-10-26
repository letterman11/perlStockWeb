#!/usr/bin/perl -w

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use GenView;
use StockUtil;
use GenModel;
use Error;
use SessionObject;
use CGI qw (:standard);
use CGI::Carp qw(fatalsToBrowser);
use Data::Dumper;

my $callObj = ();
my $sessInst = ();
my $sessID = ();
my $query = new CGI;
my %params = $query->Vars;

($callObj) = StockUtil::validateSession2();


if (ref $callObj eq 'SessionObject') { 
  
  my $model = GenModel->new(\%params);

  $model->genSQL($callObj);

  $model->execQuery(); 

  my $view = GenReport->new($model);

  $view->display2();


} else {
 
   GenLogin->new()->display();

}

