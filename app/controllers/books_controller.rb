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
    book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "投稿に成功しました。"
      redirect_to book_path(@book.id)
    else
      flash.now[:alert] = "投稿に失敗しました。" #キーをalertに変更
      render :new
    end
  end

  def index
    @books = Book.all
  end

  def top
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end
end