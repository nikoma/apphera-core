require 'net/http'
require 'json'
 
url = 'https://graph.facebook.com/v2.6/21563970?fields=first_name%2Clast_name%2Cprofile_pic%2Clocale%2Ctimezone%2Cgender&access_token=EAAclLxe8sB8BADgK8vjQtcq4HQWPhb3YCbMrCy6KOgZDZD'
uri = URI(url)
response = Net::HTTP.get(uri)
r = JSON.parse(response)
puts r["first_name"]
puts r["last_name"]
puts r["profile_pic"]
puts r["locale"]
puts r["gender"]
puts r["timezone"]


