#!ruby19
# encoding: utf-8
require "uri"
require "net/http"
require "open-uri"
require "httparty"
require "json"
require "feedjira"

class BlogFinder
  include HTTParty
  include Sidekiq::Worker

  def perform(org_id)
    org = Organization.find org_id
    url = org.url + "/feed"
    xml = HTTParty.get(url).body
    if xml
      feed = Feedjira::Feed.parse xml
      post_url = feed.entries.first.url
      post_title = feed.entries.first.title
      post_published = feed.entries.first.published
      post_author = feed.entries.first.author
      post_synopsis = feed.entries.first.summary
      Post.create!(organization_id: org.id, url: post_url, title: post_title, author: post_author, published: post_published, synopsis: post_synopsis)
    end
  end
end
