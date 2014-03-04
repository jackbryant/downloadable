class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :content

      t.timestamps
    end
  end
end
