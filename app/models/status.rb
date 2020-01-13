class Status < ApplicationRecord
  self.table_name = :statuses
  self.primary_key = :id
  
  default_scope { where(voided: 0) }

  belongs_to :site_status, class_name: 'SiteStatus', foreign_key: 'site_status_id'
end
