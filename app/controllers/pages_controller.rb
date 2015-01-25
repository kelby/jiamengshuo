class PagesController < ApplicationController
  def show
    render params[:name]
  end
end
