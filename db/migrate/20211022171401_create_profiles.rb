class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string  :name, null: false, default: ""
      t.integer :emp_no
      t.string  :grade
      t.string  :status

      t.timestamps
    end
  end
end
