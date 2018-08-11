# Home Controller
class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index dashboard]
  before_action :hawkmatrix, only: %[external]
  def index
    @token = current_user.token.token
  end

  def privacy
    render layout: 'home'
  end
  def testchat
    render layout: 'home'
  end
  def dashboard
    @token = current_user.token.token
    @scores = 0
    @concepts = 0
    @pageviews = current_user.page_views.where("created_at > ?",Date.today - 30).count
    app = App.where(public: true)
    # now you can see scores (correct answers) out of concepts
    #@scores = fb_user.facebook_user_histories.where(correct: true).where(app_id: app.id).count
    
    @apps_count = App.count
    @public_apps_count = App.where('public = true').count    
    @badges_count = current_user.badges.count
    @my_badges = current_user.badges
    render layout: 'application'
  end

  def factsheets_index
    @concepts = Concept.where(public: true)

  end
  def factsheets
    @concept = Concept.where(public: true).friendly.find(params[:id])


  end

  def external
    @contact = Contact.new
    @apps = App.all.order(:id)
    render layout: 'new_frontpage'
  end


  def home
    render layout: 'home'
  end
end
