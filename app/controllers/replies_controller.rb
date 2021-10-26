class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :readable_user, only: [:show]
  before_action :editable_user, only: [:edit, :update]

  def show
    @reply = Reply.find(params[:id])
  end

  def edit
    @reply = Reply.find(params[:id])
    @reply.this_grade ||= current_user.profile.grade
    @reply.this_status ||= current_user.profile.status
  end

  def update
    @reply = Reply.find(params[:id])
    # update_count をカウントアップする
    @reply.update_count += 1
    # 回答完了の場合、submitted_atをセット
    @reply.submitted_at = Time.current if params.has_key? :finish

    if @reply.update(reply_params)
      if params.has_key? :finish
        # 回答完了の場合
       flash[:notice] = "アンケートを回答しました。お疲れ様でした。"
        redirect_to root_url and return
      else
        flash[:notice] = "アンケートを保存しました。引き続き入力できます。"
        redirect_to request.referrer and return
      end
    else
      flash.now[:error] = "入力に誤りがあります。"
      render :edit
    end
  end

  private
    def reply_params
      params.require(:reply).permit(
        :this_grade, :this_status,
        :pj_technical_skill, :pj_relationships, :pj_appeal_problem,
        :future_job_category,
        :future_grade_1y, :future_image_1y, :future_action_1y,
        :future_grade_3y, :future_image_3y, :future_action_3y,
        :future_grade_5y, :future_image_5y, :future_action_5y,
        :this_target1, :this_target1_achv, :this_target1_remarks,
        :this_target2, :this_target2_achv, :this_target2_remarks,
        :next_target1, :next_target1_ratio,
        :next_target2, :next_target2_ratio,
        :seminor_contents, :course_hour,
        :eval_knowledge, :eval_customer, :eval_contribution, :eval_quantity_quality,
        :eval_posivity, :eval_decipline, :eval_responsibility,
        :req_manager, :req_sales, :req_admin, :req_company
      )
    end

    # アンケートが自分宛 or 送信者の場合のみ参照可能
    def readable_user
      reply = Reply.find_by(id: params[:id])
      unless reply && (reply.user == current_user || reply.enquete.sender == current_user)
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end

    # アンケートが自分宛の場合のみ編集可能
    def editable_user
      reply = Reply.find_by(id: params[:id])
      unless reply && reply.user == current_user
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end
end
