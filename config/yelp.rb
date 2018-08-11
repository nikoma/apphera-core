require 'yelp'

client = Yelp::Client.new({ consumer_key: "TQ",
                            consumer_secret: "AzM95U",
                            token: "k-SxP",
                            token_secret: "qg"
                          })


params = { term: 'reiki',
           limit: 50
         }

locale = { lang: 'en' }

res = client.search('los angeles', params, locale)

res.each do |r|
	puts r.inspect
end

