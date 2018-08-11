require 'yelp'

client = Yelp::Client.new({ consumer_key: "He-mqmSHwW8rOiJvqxR1TQ",
                            consumer_secret: "AzMDFqBkIOrOYt_a3WLJpWYU95U",
                            token: "k-kS4D0hQuMOli0PvjB2RqA6Z9KtSxP",
                            token_secret: "qeEruZ5HEup-j9VAYGrH7IPZxOg"
                          })


params = { term: 'reiki',
           limit: 50
         }

locale = { lang: 'en' }

res = client.search('los angeles', params, locale)

res.each do |r|
	puts r.inspect
end

