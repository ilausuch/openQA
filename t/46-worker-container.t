#!/usr/bin/env perl
# Copyright (C) 2020 SUSE LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.

use Test::Most;
use Test::Warnings ':report_warnings';
use File::Copy;
use File::Temp qw/ tempdir /;

my $dir = tempdir( CLEANUP => 1 );
copy("./t/data/workers.ini", "$dir/workers.ini") or die "Copy failed: $!";

is(system('docker', 'build', '-t', 'openqa_worker', 'docker/worker'), 0, 'worker container image can be built');
is(system("docker run -t -v $dir/workers.ini:/data/conf/workers.ini openqa_worker | grep 'worker connecting'"), 0, 'worker container starts');

done_testing();
