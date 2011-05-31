puts "creating seed data. please wait"
# create the admin user
email="srao@helpershub.com"
Admin.create!(:email=>email, :password=>"password")
puts "admin user with email #{email} created"

# create the default categories
%w(General Technology Corporate/Legal Finance/Accounting Marketing/Sales Business/Strategy).each { |c| Category.create!(:name=>c) }

# create the default Verticals
%w(General Technology Bio-Tech Healthcare Green/Energy Non-Profit).each { |c| Vertical.create!(:name=>c) }

# create the default Professions
%w(VC/Angels Technologists Lawyers Accountants Coaches/Mentors Marketeers Others).each { |c| Profession.create!(:name=>c) }

=begin
# create the dashboard navigation
%w(Profile Startups Requests Commitments Team/Mentors Follow(ers/ing)).each { |dNav| NavigationD.create!(:name=>dNav) }
=end
