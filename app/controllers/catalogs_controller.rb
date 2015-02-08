class CatalogsController < ApplicationController
  before_action :set_catalog, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @catalogs = Catalog.all
    respond_with(@catalogs)
  end

  def show
    respond_with(@catalog)
  end

  def new
    @catalog = Catalog.new
    respond_with(@catalog)
  end

  def edit
  end

  def create
    @catalog = Catalog.new(catalog_params)
    @catalog.save
    respond_with(@catalog)
  end

  def update
    @catalog.update(catalog_params)
    respond_with(@catalog)
  end

  def destroy
    @catalog.destroy
    respond_with(@catalog)
  end

  private
    def set_catalog
      @catalog = Catalog.find(params[:id])
    end

    def catalog_params
      params.require(:catalog).permit(:name, :info)
    end
end
