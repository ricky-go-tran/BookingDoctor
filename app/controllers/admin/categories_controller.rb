class Admin::CategoriesController < Admin::BaseController
  def index
    if params[:search]
      @categories = Category.where("UPPER(name) LIKE UPPER(?)", "%#{params[:search]}%")
    else
      @categories = Category.all
    end
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_categories.xlsx"'
        render xlsx: "index", layout: false
      }
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @category = Category.new
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, status: :see_other
  end


  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
