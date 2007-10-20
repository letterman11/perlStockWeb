#!/usr/bin/perl -w

use strict;
use IPC::Shareable;


my %default_options = (
     create    => 'yes',
     exclusive => 0,
     mode      => 0666,
     destroy   => 'yes',
     );

##### take out hard coding later #######

my $glue0='ses0';
my $glue1='ses1';
my $glue2='ses2';
my $glue3='ses3';
my $glue4='ses4';
my $glue5='ses5';
my $glue6='ses6';
my $glue7='ses7';
my $glue8='ses8';
my $glue9='ses9';

my %sessionHash0 = ();
my %sessionHash1 = ();
my %sessionHash2 = ();
my %sessionHash3 = ();
my %sessionHash4 = ();
my %sessionHash5 = ();
my %sessionHash6 = ();
my %sessionHash7 = ();
my %sessionHash8 = ();
my %sessionHash9 = ();

my $shared_handle0 = tie %sessionHash0, 'IPC::Shareable', $glue0, { %default_options } or
die "client: tie failed\n";

my $shared_handle1 = tie %sessionHash1, 'IPC::Shareable', $glue1, { %default_options } or
die "client: tie failed\n";

my $shared_handle2 = tie %sessionHash2, 'IPC::Shareable', $glue2, { %default_options } or
die "client: tie failed\n";

my $shared_handle3 = tie %sessionHash3, 'IPC::Shareable', $glue3, { %default_options } or
die "client: tie failed\n";

my $shared_handle4 = tie %sessionHash4, 'IPC::Shareable', $glue4, { %default_options } or
die "client: tie failed\n";

my $shared_handle5 = tie %sessionHash5, 'IPC::Shareable', $glue5, { %default_options } or
die "client: tie failed\n";

my $shared_handle6 = tie %sessionHash6, 'IPC::Shareable', $glue6, { %default_options } or
die "client: tie failed\n";

my $shared_handle7 = tie %sessionHash7, 'IPC::Shareable', $glue7, { %default_options } or
die "client: tie failed\n";

my $shared_handle8 = tie %sessionHash8, 'IPC::Shareable', $glue8, { %default_options } or
die "client: tie failed\n";

my $shared_handle9 = tie %sessionHash9, 'IPC::Shareable', $glue9, { %default_options } or
die "client: tie failed\n";

#------- SIGNAL CATCHERS -----------------------------------#
$SIG{KILL} = \&catchkill;
sub catchkill
{
     $SIG{KILL} = \&catchkill;
     print "######## CAUGHT KILL SIGNAL DYING #########\n";
		$shared_handle0->clean_up_all;	
		$shared_handle1->clean_up_all;	
		$shared_handle2->clean_up_all;	
		$shared_handle3->clean_up_all;	
		$shared_handle4->clean_up_all;	
		$shared_handle5->clean_up_all;	
		$shared_handle6->clean_up_all;	
		$shared_handle7->clean_up_all;	
		$shared_handle8->clean_up_all;	
		$shared_handle9->clean_up_all;	
     exit;
}

$SIG{TERM} = \&catchterm;
sub catchterm
{
     $SIG{TERM} = \&catchterm;
     print "######## CAUGHT TERM SIGNAL DYING #########\n";
		$shared_handle0->clean_up_all;	
		$shared_handle1->clean_up_all;	
		$shared_handle2->clean_up_all;	
		$shared_handle3->clean_up_all;	
		$shared_handle4->clean_up_all;	
		$shared_handle5->clean_up_all;	
		$shared_handle6->clean_up_all;	
		$shared_handle7->clean_up_all;	
		$shared_handle8->clean_up_all;	
		$shared_handle9->clean_up_all;	
     print "######## CAUGHT TERM SIGNAL SHUTTING DOWN #########\n";
     exit;
}


while (1) {
  sleep 15; # infinite server until handle of signal
#  for my $key (keys %sessionHash) {
#        print $key, "\n";
#  }
  print "*** xxx ***\n";

}

