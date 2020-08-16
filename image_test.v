module image

fn test_get_coordinates() {
	i := Image {
		file_name: "/home/anton/Downloads/20200815_133651.jpg" 
	}
	coord := i.get_coordinates() or {
		return
	}
	println(coord)
}

