class SectionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :add, :remove]
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sections = Section.present_heading_sections
    respond_with(@sections)
  end

  def show
    respond_with(@section)
  end

  def new
    @section = Section.new
    respond_with(@section)
  end

  def edit
  end

  def create
    @section = Section.new(section_params)
    @section.save
    respond_with(@section)
  end

  def update
    @section.update(section_params)
    respond_with(@section)
  end

  def destroy
    @section.destroy
    respond_with(@section)
  end

  def add
    render :add
  end

  def remove
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:heading, :body, :position, :post_id)
    end
end
