module Api
  module V1
    class SchedulesController < ApplicationController

      def index
        acc = params[:acc]
        orgid = params[:orgid] || 0
        u = @current_user
        begin
          schedules = @current_user.accounts.where(id: acc).first.organizations.where(id: orgid).first.schedules
          render :json => schedules
        rescue
          render :status => 403, :json => {:message => "Please provide a valid account_id and organization_id."}
        end

      end

      def create
        @schedule = Schedule.new(params[:schedule])
        acc = params[:acc]
        @schedule.organization_id = params[:orgid]
        @schedule.sequence_id = 10
        @schedule.organization_id = @current_user.accounts.where(id: acc).first.organizations.where(id: @schedule.organization_id).first.id
        @schedule.save!
        if @schedule
          render :json => @schedule
        else
          render :status => 403, :json => {:message => "Please provide valid parameters."}
        end

      end


    end
  end
end
