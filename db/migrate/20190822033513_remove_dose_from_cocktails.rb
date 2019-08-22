class RemoveDoseFromCocktails < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cocktails, :dose, foreign_key: true
  end
end
