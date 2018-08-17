#!ruby19
# encoding: utf-8
require "uri"
require "net/http"
require "open-uri"
require "nokogiri"

class WebserverDetector
  include Sidekiq::Worker

  def perform(org_id)
    org = Organization.find org_id
    url = org.url
    page = Nokogiri::HTML(open(url))
    server_type = page.at('meta[name="generator"]')["content"]
    OrganizationWebserver.create!(organization_id: org.id, server_type: server_type)
  end
end
