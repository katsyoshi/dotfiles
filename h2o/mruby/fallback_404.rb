Proc.new do |env|
  [404, {'content-type' => 'text/plain'}, File.open('/opt/website/top/error/404.html')]
end
