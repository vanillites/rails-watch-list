class AddMovieRefToLists < ActiveRecord::Migration[7.0]
  def change
    add_reference :lists, :movie, foreign_key: true
  end
end
