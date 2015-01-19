#!/usr/bin/perl 
use DateTime;
use DateTime::SpanSet;
use DateTime::Astro::Sunrise;

#59.308567 | Longitude : 17.999504
$latitude = "+59.308"; $longitude = "+18.000"; 
$is_off = 1;
$sr = DateTime::Astro::Sunrise->new($longitude, $latitude, 0, 3);
while (1) 
{
    $date = DateTime->now; 
    $date->set_time_zone("local");
    ($rise, $set) = $sr->sunrise($date);
    $rise->set_time_zone("local"); 
    $set->set_time_zone("local");
    $day_set = DateTime::Span->from_datetimes( start => $rise, end => $set );
    $want_off = $day_set->contains( $date ) || ( $date->hour() >= 2 && $date->hour() < 7);
    if ( !$is_off && $want_off)
    {
	    print "Turning off at: ", $date, "\n";
	    system("tdtool --off 1");
	    $is_off = 1;
    }
    elsif ($is_off && !$want_off)
    {
	print "Turning on at: ", $date, "\n";
	system("tdtool --on 1");
	$is_off = 0;
    }
    sleep 300;
}
