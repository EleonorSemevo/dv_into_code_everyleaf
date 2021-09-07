class ChangeNameNullTasks < ActiveRecord::Migration[5.2]
  change_column_null(:tasks,:name, false)
  change_column_null(:tasks, :status, false)
  change_column_null(:tasks, :content, false)
  change_column_null(:tasks, :priority, false)

end
