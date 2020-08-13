module main

import vweb

[post]
['/api/email/incoming']
fn (mut app App) incoming() vweb.Result {
	println(app.vweb.req.data)
	return app.vweb.ok(app.vweb.req.data)
}