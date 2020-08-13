module main

import vweb

const (
	http_port = 8080
)

struct App {
	pub mut:
	vweb	vweb.Context
}

fn main() {
	vweb.run<App>(http_port)
}

pub fn (mut app App) init() {}
pub fn (mut app App) init_once() {}

pub fn (mut app App) index() {
	enabled := is_email_enabled().str()
	app.vweb.text('Welcome to GGreen $enabled')
}