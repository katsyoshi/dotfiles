r = H2O::Request.new
r.status = 404
r.reason = "File Not Found"
r.send_file("/opt/website/top/error/404.html")
