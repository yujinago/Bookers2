class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @user_find = User.find(params[:id])
    if @user_find.id == current_user.id
      @user = current_user
    else
      @user = @user_find
    end
    @books = @user_find.books
  end

  def edit
    @user_find = User.find(params[:id])
    unless @user_find.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user_find = User.find(params[:id])
    if @user_find.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user_find)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
