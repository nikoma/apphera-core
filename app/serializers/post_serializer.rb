class PostSerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :title, :author, :published, :synopsis
end
