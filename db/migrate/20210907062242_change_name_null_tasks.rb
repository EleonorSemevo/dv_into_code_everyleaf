class ChangeNameNullTasks < ActiveRecord::Migration[5.2]
  change_column_null(:tasks,:name, false)
end
