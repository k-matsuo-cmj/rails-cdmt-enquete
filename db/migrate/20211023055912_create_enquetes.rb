class CreateEnquetes < ActiveRecord::Migration[6.1]
  def change
    create_table :enquetes do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.string     :title, null: false
      t.date       :deadline, null: false

      t.timestamps
    end
  end
end
