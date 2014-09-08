object @items
attributes :id, :name, :tracks, :markets
child :keyword_aggregates do
  attributes :aggregates, :created_at
end
