class MaBases < ActiveRecord::Migration
  def change
      create_table :connexions
      add_column :connexions, :ip, :string
      add_column :connexions, :user_agent, :string
      add_column :connexions, :nb, :integrer
      add_column :connexions, :date, :datetime
      create_table :recherches
      add_column :recherches, :ip, :string
      add_column :recherches, :recherche, :string
      add_column :recherches, :date, :datetime
      create_table :membres
      add_column :membres, :ip, :string
  end
end
