require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateStudents < ActiveRecord::Migration
  def change(name, options)
    # HINT: checkout ActiveRecord::Migration.create_table
    create_table(name, options)
  end
end
