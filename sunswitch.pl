#!/usr/bin/perl 
use DateTime;
use DateTime::Astro::Sunrise;
$latitude = "+48.857"; $longitude = "+2.351"; 
$sr = DateTime::Astro::Sunrise->new($longitude, $latitude, 0, 3);
$date = DateTime->now; $date->set_time_zone("local");
($rise, $set) = $sr->sunrise($date);
$rise->set_time_zone("local"); $set->set_time_zone("local");
print $rise, " to ", $set, "\n";
