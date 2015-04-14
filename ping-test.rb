require 'net/http'
header = {"User-Agent"=>"request",
 "Host"=>"apis.naver.com",
 "Progma"=>"no-cache",
 "Content-type"=>"application/x-www-form-urlencoded",
 "Accept"=>"*/*",
 "Authorization"=>"Bearer " + "AAAAN8wgRyFhowAcR4CMuvk/efAw7n+eG0Gc0xOfJKfSrm6Yg+A+4+am23oxCIgJlOVhlxVJzTXmyxYyr4k1N3YbqaQ="}
 uri = URI.parse('https://apis.naver.com/crawl/nsyndi/v2')
 http = Net::HTTP.new(uri.host, uri.port) 
 http.use_ssl = true
 args = {ping_url: "http://menumap.co.kr/syndi-test.xml"}
 uri.query = URI.encode_www_form(args)

 request = Net::HTTP::Post.new(uri.request_uri, header)
 http.request(request)
