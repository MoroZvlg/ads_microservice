Sequel.migration do
  up do
    create_table :ads, force: :cascade do |t|
      primary_key :id, type: :Bignum
      column :title, 'character varying', null: false
      column :description, 'character varying', null: false
      column :city, 'character varying', null: false
      column :lat, 'decimal(10, 7)'
      column :lon, 'decimal(10, 7)'
      column :user_id, :Bignum, null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:user_id], name: :index_user_sessions_on_user_id
    end
  end

  down do
    drop_table :ads
  end
end