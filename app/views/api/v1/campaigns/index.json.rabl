object @campaigns
attributes :id, :name, :description, :start_date, :end_date
child :keywords do
  attributes :id, :name
end