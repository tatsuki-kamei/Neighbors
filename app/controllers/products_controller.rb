class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]
  impressionist :actions=>[:show,:index]

  def rank
    @products = Product.find(Product.group(:id).order('rate desc').limit(3).pluck(:id))
    @product = Product.new
    @parents = Category.where(ancestry: nil)
    @hashtags = Hashtag.all
    render 'index'
  end

  def show
  	@product = Product.find(params[:id])
    @average = @product.comments.all.average(:score)
    @comment = Comment.new
  end

  def index
  	@products = Product.all.order(created_at: :desc).page(params[:page]) #一覧表示するためにproductモデルの情報を全てくださいのall
    @product = Product.new
    @parents = Category.where(ancestry: nil)
    @hashtags = Hashtag.all
  end

  def create
  	@product = current_user.products.new(product_params) #productモデルのテーブルを使用しているのでproductコントローラで保存する。
    @categories = Category.where(ancestry: nil)
    if @product.save #入力されたデータをdbに保存する。
      redirect_to product_path(@product), notice: "successfully created product!"#保存された場合の移動先を指定。
  	else
  		@products = Product.all
  		render 'index'
  	end
  end

  def edit
  	@product = Product.find(params[:id])
    @categories = Category.where(ancestry: nil)
    if @product.user != current_user
      render 'show'
    end
  end

  def new
  	@product = Product.new
  	@categories = Category.where(ancestry: nil)
  end



  def update
  	@product = Product.find(params[:id])
    @categories = Category.where(ancestry: nil)
  	if @product.update(product_params)
  		redirect_to product_path(@product), notice: "successfully updated product!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  	# カテゴリーに関してはあとで。もともとのカテゴリーと別のものが送られてきたら情報を上書きするような感じでかく。
  	# user/edit参照
  end

  def destroy
  	@product = Product.find(params[:id])
    if @product.user != current_user
      render 'index'
    end
  	@product.destroy
  	redirect_to products_path, notice: "successfully delete product!"
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @products = @tag.product_hashtags
  end

  def category
    @category = Category.find_by(name: (params[:name]))
  end

  private

  def product_params
  	params.require(:product).permit(:name, :image, :category_id, :text)
  end

end
