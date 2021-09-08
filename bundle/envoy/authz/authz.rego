package envoy.authz

import data.envoy.method
import input.attributes.request.http

default allow = false

allow {
	is_token_valid
	action_allowed
}

is_token_valid {
	token.valid
	now := time.now_ns() / 1000000000
	token.payload.nbf <= now
	now < token.payload.exp
}

action_allowed {
	method.is_get
	token.payload.role == "guest"
	glob.match("/people/*", ["/"], http.path)
}

action_allowed {
	method.is_get
	token.payload.role == "admin"
	glob.match("/people/*", ["/"], http.path)
}

action_allowed {
	method.is_post
	token.payload.role == "admin"
	glob.match("/people", ["/"], http.path)
	lower(input.parsed_body.firstname) != base64url.decode(token.payload.sub)
}

token := {"valid": valid, "payload": payload} {
	[_, encoded] := split(http.headers.authorization, " ")
	[valid, _, payload] := io.jwt.decode_verify(encoded, {"secret": "secret"})
}
