class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :get_request_status, only: %i[ show liked feed followers following discover ]
  before_action :profile_view_permission, only: %i[ show liked feed followers following discover ]


  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def get_request_status
      @request_status = current_user.sent_follow_requests.find_by(recipient: @user)
     ##if @current_user == @user || !@user.private? || follow_request.accepted?
    end 

    def profile_view_permission
      @view_permission = current_user == @user || !@user.private? || @request_status.accepted? 
    end
end