# frozen_string_literal: true

class CategoryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]

  # GET admin/category/
  def index
    @categorys = Category.get_categorys_orderby_display_order
  end

  # GET admin/category/1/edit
  def edit; end

  # GET admin/category/new
  def new
    @category = Category.new
  end

  # POST admin/category
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to '/admin/category', notice: 'category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT admin/area/1
  def update
    if @category.update(category_params)
      redirect_to '/admin/category', notice: 'category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE admin/area/1
  def destroy
    @category.destroy
    redirect_to '/admin/category', notice: 'category was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :display_order)
  end
end
