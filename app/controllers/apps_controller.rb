# Apps Controller
class AppsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_company_n_admin_access, except: %i[index concepts public_app public_quiz_concept submit_public_quiz_concept]
  before_action :find_app, only: %i[show]
  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Apps', :apps_url, :only => %w(index show concepts)
  expose :apps, -> { App.my_apps(current_user) }
  expose :app

  #todo: if public view - show "app store"

  def public_index
    @apps = App.all
    # render layout: "public"
  end

  def create
    app.company_id = current_user.company_id
    app.user = current_user
    if app.save
      redirect_to apps_url, notice: 'App was successfully created.'
    else
      render :new
    end
  end

  def public_app
    @public_apps = App.where('public = true').where(coming_soon: false)
  end


def public_quiz_concept
  @app = App.find(params[:app_id])
  app_concepts = @app.concepts.order(:id)
  @app_concepts_count = app_concepts.count
  # store current app to user
  current_user.app_id = @app.id
  current_user.save
  history = current_user.histories.where(app_id: @app.id).order(:id).last
  # If history.concept_id is last of app_concepts and correct:true then issue a badge and render the congratulation page
 if history
  if history.concept_id == app_concepts.last.id && history.correct == true
    # check if user already has a badge for it
    # get the specific badge
    puts "IT GOT HERE: if history.concept_id == app_concepts.last.id && history.correct == true"
    @badge = @app.badge 
    if current_user.badges.include? @badge
      #render 'enjoy_badge' and return#TODO: replace with congrats page
      redirect_to "https://www.eqbotics.com/dashboard"
      return
    else
      current_user.badges << @badge
      #render 'enjoy_badge' and return #TODO: replace with congrats page
      redirect_to "https://www.eqbotics.com/dashboard"
      return
    end
  end
  if history.correct == false
    puts "IT GOT HERE: history.correct == false"
    last_concept = current_user.histories.where(concept_id: history.concept_id).first.concept      
    @concept = last_concept
    #@concept = last_concept.next(@app.id)
    @concept_number = app_concepts.order(id: :asc).pluck(:id).index(@concept.id) + 1
  end
  if history.correct == true
    puts "IT GOT HERE: history.correct == true"
    last_concept = Concept.where(id: history.concept_id).last   
    @concept = last_concept.next(@app.id)
    @concept_number = app_concepts.order(id: :asc).pluck(:id).index(@concept.id) + 1
    History.create!(user_id: current_user.id,concept_id: @concept.id, app_id: @app.id, correct: false )
    puts "The concept should be titled #{@concept.title}"
  end
 end
  ####################
  # If history is nil show first of concept and create history item where correct:false
  ####################
  if history == nil
     @concept = app_concepts.first
     History.create!(user_id: current_user.id,concept_id: @concept.id, app_id: @app.id, correct: false )
  end
  
end
  
def submit_public_quiz_concept
  
  concept = Concept.friendly.find(params[:id])
  history = current_user.histories.where(concept_id: concept.id).last
  @app = App.find(params[:app_id])
  puts "The system thinks the answer is:" + concept.valid_answer(params[:correct_answer]).to_s
  
  if concept.valid_answer(params[:correct_answer])
    puts "It ended in concept.valid_answer(params[:correct_answer])"
    history.correct = true
    history.save
    flash.now[:notice] = 'Your answer is correct. You received 10 points.'
  else
    flash.now[:notice] = 'You need to try again - That was not it.'
  end
  params[:app] = @app.id
  redirect_to '/public_quiz_concept/'+ @app.id.to_s 
end


  # def submit_public_quiz_concept
  #   concept = Concept.find(params[:id])
  #   # TODO: REMOVE THIS / fb_user = current_user.facebook_user
  #   his = current_user.histories.last
  #   if concept.valid_answer(params[:correct_answer])
  #    # concept.create_answers_and_results(current_user, 10)
  #     his.correct = true
  #     his.save
  #     flash.now[:notice] = 'Your answer is correct. You received 10 points.'
  #   else
  #     #concept.create_answers_and_results(current_user, 0)
  #     flash.now[:error] = 'Sorry, Your answer is wrong! You can try again'
  #   end
  #   @app = App.find(params[:app_id])
  #   @concept_ids = app.concepts if @app.present?

  #   # TODO: Check if this is the last concept that has been correctly answered and create badge or show. 
  #   if app.concept_ids.last.eql?(params[:id].to_i)
  #     badge = @app.badge
  #     if current_user && badge
  #       has_badge = current_user.badges.where(id: badge.id).first
  #       unless has_badge
  #         has_badge = current_user.badges << badge
  #         # TODO: create graduation badge
  #       end
  #       if has_badge
  #         message = "Congratulations! "#You have completed the curriculum! You earned the badge! You can see and share your badge at: https://www.eqbotics.com/graduates/#{fb_user.slug} "
  #         redirect_to dashboard_path, notice: message
  #       else
  #         message = "Something went wrong when creating your badge. Please contact us!"
  #         redirect_to dashboard_path, flash: {error: message}
  #       end
  #     else
  #       message = "Something went wrong when creating your badge. Please contact us!"
  #       redirect_to dashboard_path, flash: {error: message}
  #     end

  #   else
  #     #params[:index] = params[:next_index].to_i
  #     render 'public_quiz_concept'
  #   end
  # end
  # PATCH/PUT /apps/1
  def update
    app.company_id = current_user.company_id
    app.user = current_user
    if app.update(app_params)
      redirect_to apps_url, notice: 'App was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /apps/1
  def destroy
    app.destroy if app.present?
    redirect_to apps_url, notice: 'App was successfully destroyed.'
  end

  def concepts
    add_breadcrumb "#{app.name}", :concepts_app_path
    @concepts = app.concepts
  end


  private

  def find_app
    app = App.find_by(id: params[:id])
    unless app
      redirect_to '/apps'
    end
  end

  def app_params
    params.require(:app).permit(:coming_soon,:commercial,:name, :company_id, :user_id, :title, :description, :badge, :category_id , :image, :password, :is_hawk, :public)
  end
end




# def public_quiz_concept
  #     @app = App.find(params[:app_id])
  #     app_concepts = @app.concepts
  #     current_user.app_id = @app.id
  #     current_user.save
  #     his = current_user.histories.where(app_id: @app.id).last
  #     @app_concepts_count = app_concepts.count
  #     unless his
  #       @concept = app_concepts.first
  #       @concept_number = app_concepts.order(id: :asc).pluck(:id).index(@concept.id) + 1
  #       his = History.create!(user_id: current_user.id,concept_id: @concept.id, app_id: @app.id, correct: false )
  #     end
  #   if his
  #     if his.correct == false
  #       if his
  #       @concept = Concept.where(id: his.concept_id).first
  #       end
  #       #@concept_number = app_concepts.order(id: :asc).pluck(:id).index(@concept.id) + 1
  #     else
  #       last_concept = Concept.where(id: his.concept_id).first      
  #       @concept = last_concept.next(@app.id)
  #       if @concept == nil
  #         @concept = 0
  #       end    
  #      # @concept_number = app_concepts.order(id: :asc).pluck(:id).index(@concept.id) + 1
  #      unless concept == 0
  #       History.create!(user_id: current_user.id,concept_id: @concept.id, app_id: @app.id, correct: false )
  #      end
  #     end
  #   end
  #   #@concept_ids = app_concepts if @app.present?
  #   #params[:index] = 0

  # end