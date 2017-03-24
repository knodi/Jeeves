-- generic MCV lua script
--local status, result = luup.inet.wget("http://10.0.2.1/device/2/events/new?label=:open", 5, 'cknox', 'testing123')


-- more advanced luup http request
require('ltn12')
local http = require('socket.http')

-- 5 Second timeout
socket.http.TIMEOUT = 5

local response_body = {}
local request_body = ''

local r, c, h = socket.http.request{
  url = 'http://10.0.2.1/device/2/events/new?label=:open',
  method = "GET",
  port = 80,
  -- the basic auth decodes to cknox:testing123
  headers = {
    ["HTTP_AUTHORIZATION"] = "Basic Y2tub3g6dGVzdGluZzEyMw=="
  },
  source = ltn12.source.string(request_body),
  sink = ltn12.sink.table(response_body)
}
