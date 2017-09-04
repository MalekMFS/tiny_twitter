# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Users
User.create!(name: "محمدرضا",
             email: "mohammadreza@meam.ir",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(name: "محسن",
            email: "mohsen@meam.ir",
            password:              "123456",
            password_confirmation: "123456",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)
User.create!(name: "مهدی",
           email: "mahdi@meam.ir",
           password:              "123456",
           password_confirmation: "123456",
           admin: true,
           activated: true,
           activated_at: Time.zone.now)
User.create!(name: "جواد",
          email: "javad@meam.ir",
          password:              "123456",
          password_confirmation: "123456",
          admin: true,
          activated: true,
          activated_at: Time.zone.now)
User.create!(name: "محمد",
         email: "mohammad@meam.ir",
         password:              "123456",
         password_confirmation: "123456",
         admin: true,
         activated: true,
         activated_at: Time.zone.now)
User.create!(name: "احسان",
        email: "ehsan@meam.ir",
        password:              "123456",
        password_confirmation: "123456",
        admin: true,
        activated: true,
        activated_at: Time.zone.now)
User.create!(name: "مجتبی",
        email: "mojtaba@meam.ir",
        password:              "123456",
        password_confirmation: "123456",
        admin: true,
        activated: true,
        activated_at: Time.zone.now)
User.create!(name: "محمد فرهانچی",
        email: "mohi@meam.ir",
        password:              "123456",
        password_confirmation: "123456",
        admin: true,
        activated: false,
        activated_at: Time.zone.now)
User.create!(name: "محمدرضا حجازی",
        email: "balance7910@meam.ir",
        password:              "123456",
        password_confirmation: "123456",
        admin: false,
        activated: true,
        activated_at: Time.zone.now)
User.create!(name: "علی",
        email: "ali@meam.ir",
        password:              "123456",
        password_confirmation: "123456",
        admin: true,
        activated: true,
        activated_at: Time.zone.now)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

#Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

#Following realtionships
users     = User.all
user      = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user)}
