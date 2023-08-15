# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :get_category, only: %i[show edit update destroy]

  def index
    @categories = if params[:search]
                    Category.search(params[:search])
                  else
                    Category.all
                  end
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_categories.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new, status: 422
    end
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit, status: 422
    end
  end

  def edit; end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, status: 303
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
