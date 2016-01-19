class EnableUnaccentExtension < ActiveRecord::Migration
  # You must install the contrib package before running this:
  # sudo apt-get install postgresql-contrib-9.4
  def change
    enable_extension 'unaccent'
  end
end
