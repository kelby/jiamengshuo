class AppliesController < ApplicationController
  before_action :authenticate_user!, only: [:pending_apply_students, :approve_apply, :refuse_apply, :create]

  def pending_apply_students
    @applies = Apply.pending.where(mentor_id: current_user.id).includes(:apply_student)
  end

  def approve_apply
    apply = Apply.pending.where(mentor_id: current_user.id, user_id: params[:user_id]).last

    if apply
      apply.approved!
      apply.create_activity :approve_apply, owner: current_user, recipient: apply.apply_student
    end
  end

  def refuse_apply
    apply = Apply.pending.where(mentor_id: current_user.id, user_id: params[:user_id]).last

    if apply
      apply.refused!
      apply.create_activity :refuse_apply, owner: current_user, recipient: apply.apply_student
    end
  end

  def create
    apply = Apply.new apply_params.merge(user_id: current_user.id, mentor_id: params[:user_id])
    apply.save
    apply.create_activity :create, owner: current_user, recipient_id: params[:user_id]

    respond_to do |format|
      format.js
    end
  end

  protected

  def apply_params
    params.require(:apply).permit(:info)
  end
end