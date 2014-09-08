class SlugUrl < ActiveRecord::Base
  attr_accessible :content_provider_id, :slug

  #define_index do
  #    indexes slug
  #    indexes content_provider_id
  #
  #    has content_provider_id, slug
  #  end
  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  ##
  #Tire.configure do
  #  url TIRE_IP
  #end
  #mapping do
  #  indexes :id, :index => :not_analyzed
  #  indexes :slug, :analyzer => 'snowball', :boost => 100
  #  indexes :content_provider_id, :index => :not_analyzed
  #end
  #  
  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
  #        
  #  def self.search(params)
  #          tire.search(load: true) do
  #          query { string params[:query], default_operator: "AND" } if params[:query].present?
  #                
  #    end  
  #  end

end
