task :abort_unless_test_mode => :environment do
    raise Exception.new("\e[31mDanger, Will Robinson! This command will result in a loss of any data beyond seeds.rb. It has been restricted in this app, and can only be used in the test environment. Modify this restriction in dangerous_tasks.rake.\e[0m") unless ::Rails.env.test?
end

TASKS = %w[ db:setup db:reset db:drop db:create ]

TASKS.each do |t|
	task t => :abort_unless_test_mode
end
