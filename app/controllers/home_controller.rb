# Home Controller
class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index dashboard]
  def index
   
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
