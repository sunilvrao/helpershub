puts "creating seed data. please wait"
# create the admin user
email="srao@helpershub.com"
Admin.create!(:email=>email, :password=>"password")
puts "admin user with email #{email} created"

# create the default categories
%w(introductions technology legal accounting sales strategy).each { |c| Category.create!(:name=>c) }
