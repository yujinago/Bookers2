class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
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
    book_find = Book.find(params[:id])
    book_find.update(book_params)
    redirect_to book_path(book_find)
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
end
