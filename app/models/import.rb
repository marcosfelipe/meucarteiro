class Import < ActiveRecord::Base

  has_many :import_infos

  enum status: { importing: 0, done:1 }


end
