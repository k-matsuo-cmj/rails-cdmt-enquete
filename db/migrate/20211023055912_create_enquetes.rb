class CreateEnquetes < ActiveRecord::Migration[6.1]
  def change
    create_table :enquetes do |t|
      t.references :team, null: false, foreign_key: true
      t.string     :title, null: false
      t.date       :deadline, null: false

      t.timestamps
    end
  end
end
