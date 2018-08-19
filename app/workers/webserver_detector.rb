#!ruby19
# encoding: utf-8

require "nokogiri"

class WebserverDetector
  include Sidekiq::Worker

  def perform(org_id)
    org = Organization.find org_id
    url = org.url
    page = Nokogiri::HTML(open(url)) rescue nil
    if page
      server_type = page.at('meta[name="generator"]')["content"] rescue nil
      if server_type
        OrganizationWebserver.create!(organization_id: org.id, server_type: server_type)
      end
    end
  end
end
