class GooglePlusWorker
  include Sidekiq::Worker

  def perform(p)

    GooglePlus.api_key = ENV["GOOGLE_PLUS"]

# fill in reviewer names
    search = GooglePlus::Person.search(p)
    people = []
    search.each do |p|
      people << p
    end

    # TODO: backport part of apphera enterprise API

    # GooglePlusPerson.create!(kind: p.kind, gid: p.id, image_url: p.image.url, object_type: p.object_type, display_name: p.display_name )
    details = []
    people.each do |p|
      details << GooglePlus::Person.get(p.id)
    end
    details.each do |pe|
      orgs = pe.organizations rescue nil
      lived = pe.places_lived rescue nil
      begin
        GooglePlusPerson.create!(gender: pe.gender, url: pe.url, organizations: orgs, places_lived: lived, given_name: pe.name.given_name, family_name: pe.name.family_name, kind: pe.kind, gid: pe.id, image_url: pe.image.url, object_type: pe.object_type, display_name: pe.display_name, circled_by_count: pe.circled_by_count)
      rescue Exception => e
        puts e.message
      end
    end
  end
end