Hanami::Model.migration do
  change do
    create_table :game_players do
      primary_key :id

      foreign_key :game_id, :games, on_delete: :cascade, null: false
      foreign_key :player_id, :users, on_delete: :cascade, null: false
    end
  end
end
