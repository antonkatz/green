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
	println(o)
	return extract_from_exif(o)
}

// struct Degrees {
// 	deg int
// 	min int
// 	sec f64
// }
fn extract_from_exif(output string) LatLon {
	mut re := regex.new()
	lines := output.split_into_lines()
	re.compile(r'.*(?P<d>[0-9]*) deg (?P<m>[0-9]*).*')
	
	return LatLon{
		lat: get_line(mut re, lines[0])
		lon: get_line(mut re, lines[1])
	} 
}

fn get_line(mut re regex.RE, line string) f64 {
	re.match_string(line)
	println(re.groups)
	// s_d, e_d := re.get_group('d')
	d := line[re.groups[0]..re.groups[1]]
	m := line[re.groups[2]..re.groups[3]]
	// s := line[re.groups[4]..re.groups[5]]
	println(d)
	println(m)
	return 0.0
}

fn radial_to_float(lat_lon []string) {

}