# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['Administrator','Officer'].each do |role|
  Role.create(role: role)
end


person = Person.create(gender: 'M')
user = User.create(person_id: person.id, password: 'Password!', email: 'mbwanali@pedaids.org')
UserRole.create(role_id: Role.find_by_role('Administrator').id, user_id: user.id)

#create location types
location_types = [
  'Region', 'District', 'Hospital / Health facility'
]

location_types.select do |name|
  LocationType.create(name: name)
end


['PoC', 'eMastercard'].each do |t|
  EmrSiteType.create(name: t)
end


region_location_type_id = LocationType.find_by(name: 'Region').id
district_location_type_id = LocationType.find_by(name: 'District').id
hc_location_type_id = LocationType.find_by(name: 'Hospital / Health facility').id

ems_type = EmrSiteType.find_by(name: 'eMastercard')
poc_type = EmrSiteType.find_by(name: 'Poc')

spreadsheet = Roo::Spreadsheet.open("#{Rails.root}/app/assets/data/List_of_all_eSites.xlsx")
header = spreadsheet.row(1)
(2..spreadsheet.last_row).each do |i|
  row = Hash[[header, spreadsheet.row(i)].transpose]
  region_name, district_name = row["Region"], row["District"]
  ecard = row['CDC Full site list 2']
  poc = row['EMR Sites']

  next if region_name.blank?
  region = Location.find_by(name: region_name)
  region = Location.create(name: region_name,
    location_type_id: region_location_type_id) if region.blank?

  district = Location.find_by(name: district_name)
  district = Location.create(name: district_name,
    location_type_id: district_location_type_id,
      parent_location: region.id) if district.blank?

  created_l = Location.create(name: "#{ecard}",
    location_type_id: hc_location_type_id,
      parent_location: district.id) unless ecard.blank?

  created_l = Location.create(name: "#{poc}",
    location_type_id: hc_location_type_id,
      parent_location: district.id) unless poc.blank?

  unless created_l.blank?
    EmrSite.create(location_id: created_l.id, emr_site_type_id: ems_type.id) if poc.blank?
    EmrSite.create(location_id: created_l.id, emr_site_type_id: poc_type.id) unless poc.blank?
  end

  puts "Created #{poc} ..." unless poc.blank?
  puts "Created #{ecard} ..." unless ecard.blank?
end



