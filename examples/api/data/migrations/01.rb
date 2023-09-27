class Migration01 < ::Data::Migration
  def up
    database.migrate_table :users do
      primary_key :id
      column :name, String, null: false
      column :apelido, String, unique: true, null: false
      column :nascimento, Time, null: false
      column :stack, 'text[]'
    end
  end
end