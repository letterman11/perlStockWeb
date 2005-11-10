#!/usr/bin/perl -w

use strict;
use lib "/home/abrooks/www/StockApp/script_src";
use StockUtil;
use GenModel;
use GenView;

headerHttp();
my $model = GenModel->new(StockUtil::parseParms());
$model->genSQL();
$model->execQuery();
my $view = GenView->new($model);
$view->display();
