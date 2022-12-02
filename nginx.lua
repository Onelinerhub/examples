local upload = require "upload"

local form, err = upload:new(4096)
if not form then
  ngx.say(err)
  ngx.exit(200)
end

form:set_timeout(1000)
file = io.open('/tmp/upload.tmp', "w+")

while true do
  local typ, res, err = form:read()
  if not typ then
    ngx.say(err)
    return
  end

  if typ == "body" then
    file:write(res)
  end

  if typ == "eof" then
    break
  end
end

ngx.say("file uploaded")