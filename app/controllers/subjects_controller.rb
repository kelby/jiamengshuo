class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @subjects = Subject.page(params[:page]).per(15)
    respond_with(@subjects)
  end

  def show
    @comment = @subject.comments.build
    @comments = @subject.comments.reload

    respond_with(@subject)
  end

  def new
    @subject = current_user.subjects.build
    respond_with(@subject)
  end

  def edit
  end

  def create
    @subject = current_user.subjects.build(subject_params)
    @subject.save
    respond_with(@subject)
  end

  def update
    @subject.update(subject_params)
    respond_with(@subject)
  end

  def destroy
    @subject.destroy
    respond_with(@subject)
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:title, :body)
    end
end
