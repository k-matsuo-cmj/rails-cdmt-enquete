class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.references :enquete, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.string :this_grade
      t.string :this_status

      t.text :pj_technical_skill
      t.text :pj_relationships
      t.text :pj_appeal_problem

      t.string  :future_job_category
      t.string  :future_grade_1y
      t.text    :future_image_1y
      t.text    :future_action_1y
      t.string  :future_grade_3y
      t.text    :future_image_3y
      t.text    :future_action_3y
      t.string  :future_grade_5y
      t.text    :future_image_5y
      t.text    :future_action_5y

      t.string  :this_target1
      t.integer :this_target1_achv
      t.text    :this_target1_remarks
      t.string  :this_target2
      t.integer :this_target2_achv
      t.text    :this_target2_remarks

      t.string  :next_target1
      t.integer :next_target1_ratio
      t.string  :next_target2
      t.integer :next_target2_ratio

      t.text    :seminor_contents
      t.decimal :course_hour, precision: 4, scale: 1

      t.text :eval_knowledge
      t.text :eval_customer
      t.text :eval_contribution
      t.text :eval_quantity_quality
      t.text :eval_posivity
      t.text :eval_decipline
      t.text :eval_responsibility

      t.text :req_manager
      t.text :req_sales
      t.text :req_admin
      t.text :req_company

      t.integer :update_count, null: false, default: 0
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
