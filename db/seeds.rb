# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lewarthog = User.create(username: 'lewarthog', email: 'lewarthog@hotmail.com', password: 'lewarthog')
leslie = User.create(username: 'leslie', email: 'leslie@hotmail.com', password: 'leslie')
Community.create(name:"Devs", description: "Useful programming links", creator: lewarthog, users: [lewarthog])
Community.create(name:"Vuitton", description: "Sacs et souliers", creator: leslie, users: [leslie])
Link.create(url: 'https://www.theverge.com', user: lewarthog, community: Community.first)