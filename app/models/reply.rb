class Reply < ApplicationRecord
  belongs_to :enquete
  belongs_to :user

  attr_accessor :is_finish

  with_options presence: true, if: :finish? do
    validates :pj_technical_skill, :pj_relationships, :pj_appeal_problem
    validates :future_job_category
    validates :future_grade_1y, :future_image_1y, :future_action_1y
    validates :future_grade_3y, :future_image_3y, :future_action_3y
    validates :future_grade_5y, :future_image_5y, :future_action_5y
    validates :this_target1, :this_target1_rate, :this_target1_progress, :this_target1_remarks
    validates :next_target1, :next_target1_ratio
    validates :seminor_contents, :course_hour
    validates :eval_knowledge, :eval_customer, :eval_contribution, :eval_quantity_quality
    validates :eval_posivity, :eval_decipline, :eval_responsibility
    validates :req_manager, :req_sales, :req_admin, :req_company
  end
  with_options length: { maximum: 255 } do
    validates :future_image_1y, :future_image_3y, :future_image_5y,
              :this_target1, :this_target1_progress, :this_target1_remarks,
              :this_target2, :this_target2_progress, :this_target2_remarks,
              :next_target1, :next_target2
  end
  with_options numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true do
    validates :this_target1_rate, :this_target2_rate,
              :next_target1_ratio, :next_target2_ratio
  end
  validates :course_hour, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }, allow_nil: true

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
      this_target1_rate,
      this_target1_progress,
      this_target1_remarks,
      this_target2,
      this_target2_rate,
      this_target2_progress,
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

    def finish?
      is_finish
    end
end
