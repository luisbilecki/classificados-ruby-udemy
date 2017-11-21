class AddDescriptionMdToAd < ActiveRecord::Migration
  def change
    add_column :ads, :description_md, :text
  end
end
