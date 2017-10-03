class CreateSomemodels201709211851151314 < Jennifer::Migration::Base
  def up
    create_table(:somemodel, false) do |t|
      t.integer(:id, {:primary => true, :auto_increment => true})
      t.string(:name, {:length => 100})
      t.timestamps
    end
  end

  def down
    drop_table(:somemodel)
  end
end
