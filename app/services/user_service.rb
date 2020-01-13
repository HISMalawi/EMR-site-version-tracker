
module UserService

  def self.authenticate(params)
    user = User.find_by(email: params[:email])
    return nil if user.blank?
    user.authenticate(params[:pass])
  end

  def self.assign_site(params)
    #user_assigned = UserAssignedSite.find_by(user_id: params[:user_id], location_id: params[:location_id])
    user_assigned = UserAssignedSite.find_by(location_id: params[:location_id], assigned: true)
    
    unless user_assigned.blank?
      if (user_assigned.user_id != params[:user_id].to_i)
        return user_assigned
      end
    end

    user_assigned.update_columns(assigned: params[:assigned], updated_at: Time.now()) unless user_assigned.blank?
    user_assigned = UserAssignedSite.create(user_id: params[:user_id], 
      location_id: params[:location_id], assigned: params[:assigned]) if user_assigned.blank?

    return user_assigned
  end

  def self.emr_assigned_sites(user_id)
    sites = []
    (UserAssignedSite.where(user_id: user_id, assigned: 1) || []).each do |site|
      sites << {
        location_id: site.location_id,
        location_name: Location.find(site.location_id).name,
        updated_at: site.updated_at
      }
    end

    return sites
  end

  def self.update_assigned_site(params)
    updated_date = params[:updated_date].to_date
    user_id = params[:user_id]
    location_id = params[:location_id]
    version_number = params[:version_number]
    data_up_to_date = params[:data_up_to_date]
    comments = params[:comments]
    app_in_use = (params[:application_being_used].upcase == 'YES' ? true : false)
    data_cleaned = (params[:data_cleaned].upcase == 'YES' ? true : false)
    user_id = params[:user_id]
    app_name = params[:application_name]

    enc = SiteStatus.find_by(location_id: location_id, user_id: user_id, app_name: app_name)
    unless enc.blank?
      (enc.statuses || []).each do |s|
        s.update_columns(voided: true)
      end 
      enc.update_columns(date_updated: Time.now(), voided: 1) 
    end

    enc = SiteStatus.create(location_id: location_id, user_id: user_id, 
      date_updated: updated_date, app_name: app_name)

    Status.create(site_status_id: enc.id, data_cleaning_done: data_cleaned,
      version_number: version_number, app_in_use: app_in_use, 
        last_date_used: updated_date, data_up_to_date: data_up_to_date, comments: comments)

    return enc
  end

  def self.assigned_emr_sites(params)
    statuses = SiteStatus.where(location_id: params[:location_id], 
      user_id: params[:user_id]).joins("INNER JOIN statuses s USING(site_status_id)").\
      select("s.*, site_statuses.app_name") unless params[:user_id].blank?

    statuses = SiteStatus.where(location_id: params[:location_id]).\
      joins("INNER JOIN statuses s ON s.site_status_id = site_statuses.site_status_id
      INNER JOIN users u ON u.user_id = site_statuses.user_id").\
        select("s.*, site_statuses.app_name, u.email") if params[:user_id].blank?


    return {} if statuses.blank?
    
    sites = []
    (statuses || []).each do |s|
      sites << {
        application_name: s.app_name,
        version_number: s.version_number,
        app_in_use: (s.app_in_use == 1 ? 'true' : 'false'),
        last_date_used: s.last_date_used,
        data_cleaning_done: s.data_cleaning_done,
        email: s.email,
        comments: s.comments
      }
    end

    return sites
  end

  def self.create(params)
    User.transaction do
      person = Person.create(gender: params[:gender].squish)
      user = User.create(person_id: person.id, password: params[:pass].squish, 
      email: params[:email].squish)

      UserRole.create(role_id: Role.find_by_role('Officer').id, user_id: user.id)
      PersonName.create(person_id: person.id, first_name: params[:first_name].squish, 
        last_name: params[:last_name].squish) 
      
      return user
    end

    return nil
  end

end
