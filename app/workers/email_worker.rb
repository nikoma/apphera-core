class EmailWorker
  require_relative "magic_class.rb"
  include Sidekiq::Worker
  # sidekiq_options :queue => :crawler, :retry => false
  #sidekiq_options queue: 'email'
  sidekiq_options :retry => false

  def perform(id)
    b = Organization.where(id: id).first
    puts "this is for business # #{b.id}"
    url = b.url
    email = MagicClass.get_email(url)
    description = MagicClass.get_description(url)
    b.email = email
    b.url = url
    #b.description = description
    if email.include? "["
      puts "dud"
    else
      b.save
    end
  end
end

#  lastid = Business.where("email IS NOT NULL").last.id
#  businesses = Business.where("email IS NULL").where("id > ?", lastid)

# EmailWorker.perform_async(b.id)
