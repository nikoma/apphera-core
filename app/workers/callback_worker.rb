class CallbackWorker
  include Sidekiq::Worker

  def perform(api_partner_id, topic, priority='normal', message='')
    @api_partner = ApiPartner.find api_partner_id
    @partner_token = @api_partner.partner_token
    @callback_url = @api_partner.callback_url

    HTTParty.post(@callback_url,
                  :body => {
                      :topic => topic,
                      :priority => priority,
                      :message => message
                  }.to_json, :headers => {"callback_token" => @partner_token});
  end
end