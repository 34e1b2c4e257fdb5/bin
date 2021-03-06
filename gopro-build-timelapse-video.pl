#!/usr/bin/env perl
use v5.18;
use strict;
use warnings;

use File::Basename 'basename';
use List::MoreUtils 'uniq';

my $output_dir_base = "/tmp/gopro-timelapse";
mkdir($output_dir_base) unless -d $output_dir_base;

my @pic = </Volumes/*/DCIM/*GOPRO/G*.JPG>;
my %pic_groups;
for my $f (@pic) {
    my $g = substr(basename($f), 0, 4);
    push @{$pic_groups{$g}}, $f;
}

for my $g (keys %pic_groups) {
    my @files = sort { $a cmp $b } @{$pic_groups{$g}};

    my $output_dir = $output_dir_base . "/$g";
    mkdir($output_dir) unless -d $output_dir;

    my $counter = 0;
    for my $f (@files) {
        $counter++;
        my $f2 = sprintf("%s/pic-%05d.jpg", $output_dir, $counter);
        symlink($f, $f2);
    }
}
