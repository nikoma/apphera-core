class CompSearch
  include Sidekiq::Worker

  def perform(org)
    @org = Organization.find org
    comps = Organization.where(category_id: @org.category_id).near(@org, 40, :order => "distance").limit(20)
    if comps
      comps.each do |c|
        @org.organizations << c
        if c.provider_slugs.count < 1
          BingApi.perform_async(c.id)
        end
      end
    end
    @org.save
  end
end