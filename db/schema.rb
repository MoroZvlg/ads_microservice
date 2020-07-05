Sequel.migration do
  change do
    create_table(:ads, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      String :title, :null=>false
      String :description, :null=>false
      String :city, :null=>false
      BigDecimal :lat, :size=>[10, 7]
      BigDecimal :lon, :size=>[10, 7]
      Bignum :user_id, :null=>false
      DateTime :created_at, :size=>6, :null=>false
      DateTime :updated_at, :size=>6, :null=>false
      
      index [:user_id], :name=>:index_user_sessions_on_user_id
    end
    
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
  end
end
