puts "creating seed data. please wait"
# create the admin user
email="srao@helpershub.com"
Admin.create!(:email=>email, :password=>"password")
puts "admin user with email #{email} created"

# create the default categories
%w(General Technology Corporate/Legal Finance/Accounting Marketing/Sales Business/Strategy).each { |c| Category.create!(:name=>c) }

# create the dashboard navigation
%w(Profile Startups Requests Commitments Team/Mentors Follow(ers/ing)).each { |dNav| NavigationD.create!(:name=>dNav) }

# create the Contributor navigation
%w(Entrepreneurs Technologists Lawyers Accountants Coaches/Mentors Marketeers).each { |cNav| NavigationD.create!(:name=>cNav) }
