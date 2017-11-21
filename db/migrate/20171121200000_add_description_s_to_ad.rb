class AddDescriptionSToAd < ActiveRecord::Migration
  def change
    add_column :ads, :description_short, :text
  end
end
