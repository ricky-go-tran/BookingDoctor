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
      respond_to do |format|
        format.html { redirect_to admin_categories_path, notice: 'Categories was successfully created.' }
        format.turbo_stream do
          render layout: false
        end
      end

    else
      render :new, status: 422, layout: false
    end
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to redirect_to admin_categories_path, notice: 'Category was successfully updated.' }
        format.turbo_stream
      end
    else
      render :edit, status: 422, layout: false
    end
  end

  def edit; end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_path notice: 'Category was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
