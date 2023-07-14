class BooksController < ApplicationController
  def index
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def show
  end
  
  private
  
  def book_params
    params.require(:book).premit(:title, :body)
  end
end
