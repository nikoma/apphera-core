class GooglePlusPerson < ActiveRecord::Base
  #attr_accessible :gender, :url, :organizations, :places_lived, :given_name, :family_name, :kind, :gid, :image_url, :object_type, :display_name, :circled_by_count
  serialize :organizations, ActiveRecord::Coders::NestedHstore
  serialize :places_lived, ActiveRecord::Coders::NestedHstore
end
