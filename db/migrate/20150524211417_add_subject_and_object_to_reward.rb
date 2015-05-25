class AddSubjectAndObjectToReward < ActiveRecord::Migration
  def change
  	add_column :rewards, :subject, :integer
  	add_column :rewards, :object, :integer
  end
end
