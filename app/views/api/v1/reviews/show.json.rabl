object @reviews
attributes :id, :organization_id, :content_provider_id, :review_date, :reviewer_id, :title, :body, :rating, :review_url

child (:reviewer) do
attributes :name, :slug, :imageurl
end

