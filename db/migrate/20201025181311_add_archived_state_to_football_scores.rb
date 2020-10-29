class AddArchivedStateToFootballScores < ActiveRecord::Migration[6.0]
  def change
    add_column :football_scores, :archived_state, :boolean, default: false
  end
end
