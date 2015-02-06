class AppliesController < ApplicationController
  before_action :authenticate_user!, only: [:pending_apply_students, :approve_apply, :refuse_apply]

  def pending_apply_students
    @pending_apply_students = current_user.pending_apply_students
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
end