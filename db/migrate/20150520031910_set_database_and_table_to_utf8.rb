class SetDatabaseAndTableToUtf8 < ActiveRecord::Migration
  def db_name
    db_info = Rails.application.config.database_configuration[::Rails.env]
    db_info["database"] if db_info
  end

  def table_names
    ActiveRecord::Base.connection.tables
  end

  def up
    execute "ALTER DATABASE #{db_name} CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

    table_names.each do |table_name|
      execute "ALTER TABLE #{table_name} CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
    end
  end

  def down
  end
end
