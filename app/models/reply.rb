class Reply < ApplicationRecord
  belongs_to :enquete
  belongs_to :user

  def to_csv
    [
      user.user_name,
      format_datetime(submitted_at),
      user.profile.emp_no,
      this_grade,
      this_status,
      pj_technical_skill,
      pj_relationships,
      pj_appeal_problem,
      future_job_category,
      future_grade_1y,
      future_image_1y,
      future_action_1y,
      future_grade_3y,
      future_image_3y,
      future_action_3y,
      future_grade_5y,
      future_image_5y,
      future_action_5y,
      this_target1,
      this_target1_achv,
      this_target1_achv,
      this_target1_remarks,
      this_target2,
      this_target2_achv,
      this_target2_achv,
      this_target2_remarks,
      next_target1,
      next_target1_ratio,
      next_target2,
      next_target2_ratio,
      seminor_contents,
      course_hour,
      eval_knowledge,
      eval_customer,
      eval_contribution,
      eval_quantity_quality,
      eval_posivity,
      eval_decipline,
      eval_responsibility,
      req_manager,
      req_sales,
      req_admin,
      req_company
    ]
  end

  private
    def format_datetime(datetime)
      datetime.strftime("%Y/%m/%d %H:%M:%S") unless datetime.nil?
    end
end
