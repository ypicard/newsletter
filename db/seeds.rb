# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'lewarthog', email: 'lewarthog@hotmail.com', password: 'lewarthog')
Community.create(name:"Devs", creator: User.first, users: [User.first])
Link.create(url: 'https://www.theverge.com', user: User.first, community: Community.first)