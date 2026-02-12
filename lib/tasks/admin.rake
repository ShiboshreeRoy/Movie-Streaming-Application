namespace :admin do
  desc "Create admin user"
  task create: :environment do
    puts "Creating admin user..."
    
    admin = User.find_or_create_by(email: 'admin@example.com') do |user|
      user.first_name = 'Admin'
      user.last_name = 'User'
      user.password = 'password123'
      user.password_confirmation = 'password123'
    end
    
    # Ensure admin role is set
    admin.update(role: 1)
    
    if admin.persisted?
      puts "✅ Admin user created/updated successfully!"
      puts "Email: admin@example.com"
      puts "Password: password123"
      puts "Role: Admin (#{admin.role})"
    else
      puts "❌ Failed to create admin user:"
      admin.errors.full_messages.each { |msg| puts "  - #{msg}" }
    end
  end
  
  desc "List all admin users"
  task list: :environment do
    admins = User.where(role: 1)
    if admins.any?
      puts "Admin users:"
      admins.each do |admin|
        puts "- #{admin.email} (#{admin.full_name})"
      end
    else
      puts "No admin users found"
    end
  end
end