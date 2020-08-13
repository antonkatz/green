module main

import vweb

['/api/email/incoming']
pub fn (mut app App) incoming() vweb.Result {
	return app.vweb.ok('Email received')
}

pub fn is_email_enabled() {
	return true
}