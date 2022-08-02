class DeleteMovieRefFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :movie_id
  end
end
