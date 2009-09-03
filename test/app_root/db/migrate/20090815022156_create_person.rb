class CreatePerson < ActiveRecord::Migration
  def self.up
    create_table :person do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.date :birthday
    end
  end

  def self.down
    drop_table :people
  end
end
