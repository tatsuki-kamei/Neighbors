class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  end

  def index
  	@products = Product.all #一覧表示するためにproductモデルの情報を全てくださいのall
    @product = Product.new
  end

  def create
  	@product = Product.new(product_params) #productモデルのテーブルを使用しているのでproductコントローラで保存する。
    if @product.save #入力されたデータをdbに保存する。
      redirect_to product_path(@product), notice: "successfully created product!"#保存された場合の移動先を指定。
  	else
  		@products = Product.all
  		render 'index'
  	end
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def new
  	@product = Product.new
  	@categories = Category.all
  end



  def update
  	@product = Product.find(params[:id])
  	if @product.update(product_params)
  		redirect_to @product, notice: "successfully updated product!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  	# カテゴリーに関してはあとで。もともとのカテゴリーと別のものが送られてきたら情報を上書きするような感じでかく。
  	# user/edit参照
  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to products_path, notice: "successfully delete product!"
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @products = @tag.product_hashtags
  end

  private

  def product_params
  	params.require(:product).permit(:name, :image, :category_id, :text)
  end

end