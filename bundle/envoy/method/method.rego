package envoy.method

import input.attributes.request.http

is_get {
  	http.method == "GET"
}

is_post {
  	http.method == "POST"
}
