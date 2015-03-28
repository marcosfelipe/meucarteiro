class Import < ActiveRecord::Base

  require 'carrierwave/orm/activerecord'

  belongs_to :user

  has_many :import_infos

  enum status: { importing: 0, done:1 }

  mount_uploader :file, ContactsUploader

  validate :file_size

  private

  def file_size
    errors[:file] << "should be less than 5MB" if file.size > 5.megabytes
  end



end
