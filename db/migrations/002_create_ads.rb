Sequel.migration do
  up do
    create_table(:ads) do
      primary_key :id
      String :title, null: false
      Text :description, null: false
      String :city
      Decimal :lat
      Decimal :lot
      foreign_key :user_id, :users, null: false, index: true, on_delete: :cascade
    end
  end

  down do
    drop_table(:ads)
  end
end
