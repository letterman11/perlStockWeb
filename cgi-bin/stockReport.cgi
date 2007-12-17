#!/usr/bin/perl -wT

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
my $initSessionObject = ();
my $query = new CGI;
my %params = $query->Vars;

$initSessionObject = StockUtil::validateSession();

if (ref $initSessionObject eq 'SessionObject') { 

       $sessInst = $initSessionObject->{INSTANCE};
       $sessID =  $initSessionObject->{SESSIONID};
	#$userID = $cookies{'stock_UserID'}->value;
    
       my $model = GenModel->new(\%params);
    
       $model->genSQL();
       my ($data, $rowcount) = $model->execIndexQuery();
       my $sessionObject = SessionObject->new($sessInst,
    					 $sessID,
    					 $data,
    					 $rowcount);
    
       StockUtil::storeSessionObject($sessionObject);
    
       $model->genSQL($sessionObject);

       $model->execQuery();

       my $view = GenReport->new($model);

       $view->display2();


} else {
 
	GenLogin->new()->display();

}

