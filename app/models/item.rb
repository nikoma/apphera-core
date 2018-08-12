class Item < ActiveRecord::Base
  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  # serialize :properties, ActiveRecord::Coders::Hstore
  #attr_accessible :account_id, :body, :completed, :folder, :new, :organization_id, :rating, :reminder, :reviewer_id, :source, :subject, :kind_id, :visible, :properties
  belongs_to :kind
  belongs_to :organization
  belongs_to :reviewer

  %w[sentiment].each do |key|
   # attr_accessible key
    scope "has_#{key}", lambda { |value| where("properties @> hstore(?, ?)", key, value) }

    define_method(key) do
      properties && properties[key]
    end

    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end

end
