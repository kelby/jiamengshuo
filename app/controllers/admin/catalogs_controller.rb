class Admin::CatalogsController < ApplicationController
  before_action :set_admin_catalog, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @admin_catalogs = Admin::Catalog.all
    respond_with(@admin_catalogs)
  end

  def show
    respond_with(@admin_catalog)
  end

  def new
    @admin_catalog = Admin::Catalog.new
    respond_with(@admin_catalog)
  end

  def edit
  end

  def create
    @admin_catalog = Admin::Catalog.new(catalog_params)
    @admin_catalog.save
    respond_with(@admin_catalog)
  end

  def update
    @admin_catalog.update(catalog_params)
    respond_with(@admin_catalog)
  end

  def destroy
    @admin_catalog.destroy
    respond_with(@admin_catalog)
  end

  private
    def set_admin_catalog
      @admin_catalog = Admin::Catalog.find(params[:id])
    end

    def catalog_params
      params.require(:admin_catalog).permit(:name)
    end
end
