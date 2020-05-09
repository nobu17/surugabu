# frozen_string_literal: true

class AreaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area, only: [:edit, :update, :destroy]

  # GET admin/area/
  def index
    @areas = Area.get_areas_orderby_display_order
  end

  # GET admin/area/1/edit
  def edit; end

  # GET admin/area/new
  def new
    @area = Area.new
  end

  # POST admin/area
  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to '/admin/area', notice: 'Area was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT admin/area/1
  def update
    if @area.update(area_params)
      redirect_to '/admin/area', notice: 'Area was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE admin/area/1
  def destroy
    @area.destroy
    redirect_to '/admin/area', notice: 'Area was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @area = Area.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def area_params
    params.require(:area).permit(:name, :display_order)
  end
end
