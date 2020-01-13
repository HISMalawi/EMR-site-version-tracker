module LocationService

  def self.emr_list
    location_type = LocationType.find_by(name: 'Hospital / Health facility')
    locations = []
    Location.where(location_type_id: location_type.id).joins("INNER JOIN location parent 
      ON parent.location_id = location.parent_location
      INNER JOIN emr_site e ON e.location_id = location.location_id
      INNER JOIN emr_site_type et ON et.emr_site_type_id = e.emr_site_type_id").\
        select("location.name, parent.name district, location.location_id,
          et.name emr_type").each do |location|
      locations << {
        district:  location.district,
        name: location.name,
        location_id: location.location_id,
        emr_type: location.emr_type
      }
    end

    return locations
  end

end
