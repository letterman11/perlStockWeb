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

my $sessInst = ();
my $sessID = ();
my $userID = ();
my $query = new CGI;
my %params = $query->Vars;
my %cookies = fetch CGI::Cookie;


if (defined $cookies{'Instance'} &&
                              defined $cookies{'stock_SessionID'} &&
                                    defined $cookies{'stock_UserID'})  {

       $sessInst = $cookies{'Instance'}->value;
       $sessID = $cookies{'stock_SessionID'}->value;
       $userID = $cookies{'stock_UserID'}->value;
    
       my $model = GenModel->new(\%params);
    
       $model->genSQL();
       my ($data, $rowcount) = $model->execIndexQuery();
       my $sessionObject = SessionObject->new($sessInst,
    					 $sessID,
    					 $data,
    					 $rowcount);
    
#       LOGGER::LOG("$sessInst ______ $sessID  ______ $data ____ $rowcount");
       StockUtil::storeSessionObject($sessionObject);
    
       $model->genSQL($sessionObject);

       $model->execQuery();

       my $view = GenReport->new($model);

       $view->display2();


} else {
 
	GenLogin->new()->display();

}

