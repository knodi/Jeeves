-- generic MCV lua script
local status, result = luup.inet.wget("http://10.0.2.1/device/2/events/new?label=:open", 5, 'cknox', 'testing123')
