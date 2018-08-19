#!ruby19
# encoding: utf-8

class PostWorker
  include Sidekiq::Worker

  def perform(org_id)
    org = Organization.find org_id
    url = org.url + "/feed/"
    xml = HTTParty.get(url).body rescue nil
    if xml
      feed = Feedjira::Feed.parse xml
      post_url = feed.entries.first.url
      post_title = feed.entries.first.title
      post_published = feed.entries.first.published
      post_author = feed.entries.first.author
      post_summary = feed.entries.first.summary rescue nil
      Post.create!(organization_id: org_id, title: post_title, author: post_author, published: post_published, synopsis: post_summary, url: post_url)
    end
  end
end

#  t.integer "organization_id"
#  t.string "title"
#  t.string "author"
#  t.datetime "published"
#  t.string "synopsis"
#  t.datetime "created_at", null: false
#  t.datetime "updated_at", null: false
#  t.string "url"
