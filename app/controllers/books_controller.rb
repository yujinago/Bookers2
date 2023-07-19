class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.new
    @book_find = Book.find(params[:id])
    if @book_find.user.id == current_user.id
      @user = current_user
    else
      @user = @book_find.user
    end
  end
  
  def edit
    @book_find = Book.find(params[:id])
  end
  
  def update
    @book_find = Book.find(params[:id])
    if @book_find.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book_find)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book_find = Book.find(params[:id])
    unless book_find.user.id == current_user.id
      redirect_to books_path
    end
  end
    
end
