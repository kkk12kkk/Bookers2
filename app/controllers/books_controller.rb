class BooksController < ApplicationController
  def new
    @book = Books.new
  end

  def edit
    # ここから追加
    book = Book.find(params[:id])
    unless book.id == current_book.id
      redirect_to post_images_path
    end
    # ここまで追加
  
    @book = Book.find(params[:id])
  end


  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "You have creatad book successfully"
      redirect_to book_path(@book.id)
    else
      flash[:alert] = @book.errors.full_messages.join("activerecord.errors.models.book.") #キーをalertに変更
      @user = current_user
      @books = Book.all
      @newbook = Book.new
      @user = user.all
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
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end
end