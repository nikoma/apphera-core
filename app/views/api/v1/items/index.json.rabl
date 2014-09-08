object false
node :items do
@items.map do |item|
    item.to_json
 end
end
