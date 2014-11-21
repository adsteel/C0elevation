

###     BE CAREFUL    ####

###     Data in this file is configured to accommodate dependies throughout the app. Changing data, particularly ID numbers, will break the app.

###     BE CAREFUL    ####



#Activities

	rock_climb = Activity.find_or_initialize_by(id: 2)
	rock_climb.update({
		:title => 'Rock Climbing', 
		:description => 'Climb quickly and comfortably up classic crack climbs with a classy, commanding kletterfuhren using quirky climbing configurations.',
		:icon => File.new("#{Rails.root}/app/assets/images/activity_icons/rock_climbing_2.jpg")
		})

	mtn_bike = Activity.find_or_initialize_by(id: 1)
	mtn_bike.update({ 
		:title => 'Mountain Biking', 
		:description => 'Swoop swiftly over sweet singletrack soirees with a sassy, saucy, single sender.',
		:icon => File.new("#{Rails.root}/app/assets/images/activity_icons/backpacking_2.jpg")
		})

	fly_fish = Activity.find_or_initialize_by(id: 3)
	fly_fish.update({ 
		:title => 'Fly Fishing', 
		:description => 'Fetch freaking fat fish with a fine, fetching fly fishing fellow.',
		:icon => File.new("#{Rails.root}/app/assets/images/activity_icons/fly_fishing_2.jpg")
		})



#Locations
	location = Location.find_or_initialize_by(id: 1)
		
	location.update({
		:description => "Example location",
		})

###     BE CAREFUL    ####

###     Data in this file is configured to accommodate dependies throughout the app. Changing data, particularly ID numbers, will break the app.

###     BE CAREFUL    ####

#Company

	company = Company.find_or_initialize_by(id: 1)

	company.update({
		:name => "Example company",
		:email => "info@examplecompany.com",
		:owner_id => 2,
		:contact_name => "Gerald",
		:hq_address => "123 Sesame St.",
		:hq_city => "Boulder",
		:hq_state => "CO",
		:country => "USA",
		:description => "Rutrum at tempor a, pellentesque sit amet est. Etiam vestibulum enim ac quam mollis congue. Cras a diam",
		:owner_id => "1",
		:phone => "3035551212"
		})



#Users

if Rails.env.development?

	steel = User.find_or_initialize_by(id: 1)
	steel.update({
		:admin => true,
		:first => "Adam",
		:last => "Steel",
		:email => "adamgsteel@gmail.com",
		:password => "animals1",
		:password_confirmation => "animals1",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})

	dengler = User.find_or_initialize_by(id: 2)
	dengler.update({
		:admin => true,
		:first => "Adam",
		:last => "Dengler",
		:email => "adam.dengler@gmail.com",
		:password => "animals1",
		:password_confirmation => "animals1",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})


	admin = User.find_or_initialize_by(id: 3)
	admin.update({
		:admin => true,
		:first => "Admin",
		:last => "User",
		:email => "admin@coelevation.com",
		:password => "animals1",
		:password_confirmation => "animals1",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})
		
	guest = User.find_or_initialize_by(id: 4)
	guest.update({
		:admin => false,
		:first => "Guest",
		:last => "Guide",
		:email => "guest@coelevation.com",
		:password => "guestguide",
		:password_confirmation => "guestguide",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})

end

if Rails.env.production?
	steel = User.find_or_initialize_by(id: 1)
	steel.update({
		:admin => true,
		:first => "Adam",
		:last => "Steel",
		:email => "asteel@coelevation.com",
		:password => "animals2",
		:password_confirmation => "animals2",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})

	dengler = User.find_or_initialize_by(id: 2)
	dengler.update({
		:admin => true,
		:first => "Adam",
		:last => "Dengler",
		:email => "adengler@coelevation.com",
		:password => "animals2",
		:password_confirmation => "animals2",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})

	admin = User.find_or_initialize_by(id: 3)
	admin.update({
		:admin => true,
		:first => "Admin",
		:last => "User",
		:email => "admin@coelevation.com",
		:password => "animals2",
		:password_confirmation => "animals2",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})

	guest = User.find_or_initialize_by(id: 4)
	guest.update({
		:admin => false,
		:first => "Guest",
		:last => "Guide",
		:email => "guest@coelevation.com",
		:password => "guestguide",
		:password_confirmation => "guestguide",
		:accept_terms => true,
		:confirmed_at => Time.now,
		})
end


#Guides

	guide_one = Guide.find_or_initialize_by(id: 1)
	guide_one.update({
		:user_id => 1,
		:intro => "Maecenas a massa lorem. Fusce auctor convallis sem. Phasellus imperdiet, nisi quis sagittis sodales, ligula mi euismod lorem, eu tempus felis risus vitae nisl. Nulla quam elit, rutrum at tempor a, pellentesque sit amet est. Etiam vestibulum enim ac quam mollis congue. Cras a diam quis felis ullamcorper mattis ac pharetra erat",
		:approved => true,
		:accept_terms => true
		})

	guide_two = Guide.find_or_initialize_by(id: 2)
	guide_two.update({
		:id => 2,
		:user_id => 4,
		:intro => "Maecenas a massa lorem. Fusce auctor convallis sem. Phasellus imperdiet, nisi quis sagittis sodales, ligula mi euismod lorem, eu tempus felis risus vitae nisl. Nulla quam elit, rutrum at tempor a, pellentesque sit amet est. Etiam vestibulum enim ac quam mollis congue. Cras a diam quis felis ullamcorper mattis ac pharetra erat",
		:approved => true,
		:accept_terms => true
		})

#Trips

	6.times do |i|
		trip = Trip.find_or_initialize_by(id: i)
		trip.update({
				:activity_id => 1,
				:guide_id => 1,
				:difficulty => Trip::DIFFICULTIES[0],
				:length => Trip::LENGTHS[0],
				:location_id => 1,
				:company_id => 1,
				:service_tax => 0.01,
				:latitude => "44.981165",
				:longitude => "-93.279225",
				:one_liner => "A sexy one liner to catch your eye",
				:short_description => "Vivamus ac commodo sapien, a hendrerit nisl. Proin congue sapien non dapibus vulputate. Duis ornare sit amet mauris nec facilisis. Nulla molestie, purus sed venenatis ultricies,",
				:description => "Curabitur eros tortor, tincidunt eu malesuada eget, dignissim et orci. Nulla a dapibus quam, molestie placerat orci. Duis sodales dolor ligula, eu faucibus dui aliquam in. Vivamus ac commodo sapien, a hendrerit nisl. Proin congue sapien non dapibus vulputate. Duis ornare sit amet mauris nec facilisis. Nulla molestie, purus sed venenatis ultricies, nulla ligula dignissim justo, eu adipiscing nibh leo ac leo. Sed venenatis metus ac lectus rutrum faucibus. Integer sodales sapien elementum dignissim pretium.",
				:required_gear => "Snacks\nRain Gear\nWater Bottle",
				:supplied_gear => "The big stuff\nHelmet\nLunch",
				:itinerary => "Start at the place\nGet the stuff\nDrive elsewhere\nDo something rad",
				:private => true,
				:max => 4,
				:time_of_year => "About mid-season to mid-season, but it's good all year round.",
				:title => i.to_s + " Backpacking and beer drinking in Yosemite",
				:length_description => "4-6 hours",
				:skill_level => Trip::SKILLS[0]
			})

	  #Trip Costs
		trip_cost = TripCost.find_or_initialize_by(id: i)
		trip_cost.update({ 
			trip_id: trip.id,
			one: 200,
			two: 0,
			three: 50,
			four: 50,
			five: 50,
			six: 50,
			seven: 50,
			eight: 50,
			nine: 50,
			ten: 50
		})

	end

#TripDates

6.times do |t|
	4.times do |d|
		new_id = 4*(t-1)+d
		new_date = Date.today + 365 + new_id
		dates = TripDate.find_or_initialize_by(id: new_id)
		dates.update({
			:trip_id => t,
			:start_date => new_date,
			:end_date => new_date,
			:start_time => "14:59:08",
			})
	end
end