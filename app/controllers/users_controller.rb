class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms
  end

  def edit
  end

  def update
  end

end
