class SiteStatus < ApplicationRecord
  self.table_name = :site_statuses
  self.primary_key = :site_status_id
  
  default_scope { where(voided: 0) }
  has_many :statuses, class_name: 'Status', foreign_key: 'site_status_id'

end
