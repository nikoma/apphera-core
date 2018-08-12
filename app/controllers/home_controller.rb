# Home Controller
class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!, only: %i[index dashboard]



  
  def index
   puts "hit"
    render layout: 'home'

  end

  def privacy
    render layout: 'home'
  end
  def testchat
    render layout: 'home'
  end
  def dashboard
   
    render layout: 'application'
  end

  def external
   
    render layout: 'new_frontpage'
  end


  def home
    render layout: 'home'
  end
end
