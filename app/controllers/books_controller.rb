class BooksController < ApplicationController
  def new
    @book = Books.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end


  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @newbook.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "You have creatad book successfully"
      redirect_to book_path(@newbook.id)
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def index
      @users = User.all
    if current_user
      @user = current_user
    end
      @books = Book.all
      @newbook = Book.new
  end

   def show
      @newbook = Book.new
      @book = Book.find(params[:id])
      @user = @book.user
   end

  def top
  end

  def update
    @book = Book.find(params[:id])
    @book.assign_attributes(book_params)
    
    
     if @book.save
       flash[:notice] = "Book was successfully updated"
       redirect_to book_path(@book.id)
     else
       flash.now[:alert] = @book.errors.full_messages.join
       render :edit
      end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
       flash[:notice]="Book was successfully destroyed"
       redirect_to books_path
    end
  end

  private

  def book_params
     params.require(:book).permit(:title, :body)
  end

  def after_sign_out_path_for(resource_or_scope)
     new_user_session_path
  end
end
  