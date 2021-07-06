require "bcrypt"
salt = BCrypt::Engine.generate_salt
encrypted_password = BCrypt::Engine.hash_secret('password', salt)

User.new(:email => "bike@bikelover.org", :encrypted_password => encrypted_password).save(validate: false);

Bike.create!(log_number: 1, brand: "Schwinn", model: "Paramount", bike_type: "Road", color: "Radiant Coppertone", purpose: "Sale", price: 300, serial_number: "22bikebike22")
Bike.create!(log_number: 2, brand: "Schwinn", model: "Paramount", bike_type: "Road", color: "Flamboyant Lime", purpose: "Freecyclery", serial_number: "33bikebike33")
