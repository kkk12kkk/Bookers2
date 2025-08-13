class UsersController < ApplicationController
  def new
    @user = @User.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    user = User.new(user_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    user.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "投稿に成功しました。"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "投稿に失敗しました。" #キーをalertに変更
      render :new
  end

  def index
    @users = User.all  
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
  end

  def destroy
    user = User.find(params[:id])  # データ（レコード）を1件取得
    user.destroy  # データ（レコード）を削除
    redirect_to '/users'  # 投稿一覧画面へリダイレクト
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end
