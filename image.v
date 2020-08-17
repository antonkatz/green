module image

import os
import regex

struct Image {
	file_name string
}

struct LatLon {
	lat f64
	lon f64
}

pub fn (i Image) get_coordinates() ?LatLon {
	r := os.exec('exiftool -gpslongitude -gpslatitude $i.file_name')?
	o := r.output 
	return extract_from_exif(o)
}

fn extract_from_exif(output string) LatLon {
	mut re := regex.new()
	lines := output.split_into_lines()
	re.compile(r'.*(?P<d>[0-9]*) deg (?P<m>[0-9]+).+(?P<s>[0-9.]+).+([A-Z])+')
	
	return LatLon{
		lat: parse_line(mut re, lines[0])
		lon: parse_line(mut re, lines[1])
	} 
}

fn parse_line(mut re regex.RE, line string) f64 {
	re.match_string(line)
	d := line[re.groups[0]..re.groups[1]].int()
	m := line[re.groups[2]..re.groups[3]].int()
	s := line[re.groups[4]..re.groups[5]].f64()
	geo_d := line[re.groups[6]..re.groups[7]]
	return radial_to_float(d,m,s,geo_d)
}

fn radial_to_float(d, m int, s f64, dir string) f64 {
	mag := d + (m / 60) + (s / 3600)
	if dir in ['S', 'W'] {return mag * -1}
	return mag
}