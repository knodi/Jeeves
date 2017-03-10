-- generic MCV lua script
local status, result = luup.inet.wget("http://raspberrypi.local:3000/events/new?d=back%20door&l=back%20door%20open", 5, 'cknox', 'testing123')

