class AddSlugToFootballScores < ActiveRecord::Migration[6.0]
  def change
    add_column :football_scores, :slug, :string
  end
end
