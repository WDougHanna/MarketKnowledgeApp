# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


submarket_list = ["Allen/McKinney",   
    "Alliance",
    "Arlington/Mansfield",     
    "Central Expressway",      
    "Dallas CBD",      
    "Delta County",        
    "Denton",      
    "DFW Freeport/Coppell",        
    "East LBJ Freeway",        
    "East Northeast Ft Worth",     
    "Ellis County",        
    "Frisco/The Colony",       
    "Ft Worth CBD",        
    "Garland",     
    "Grand Prairie",       
    "HEB/Midcities",       
    "Henderson County",        
    "Hood County",     
    "Hunt County",     
    "Johnson County",      
    "Lewisville",      
    "Mesquite/Forney/Terrell",     
    "Northwest Ft Worth",      
    "Office Ctr/West LBJ Ext",     
    "Outlying Collin County",      
    "Outlying Denton County",      
    "Outlying Kaufman County",     
    "Parker County",      
    "Plano",       
    "Preston Center",      
    "Quorum/Bent Tree",        
    "Richardson",      
    "Rockwall",        
    "South Irving",        
    "Southeast Dallas",        
    "Southeast Ft Worth",      
    "Southwest Dallas",        
    "Stemmons Freeway",        
    "Upper Tollway/West Plano",        
    "Uptown/Turtle Creek",     
    "Urban Center/Wingren",        
    "West LBJ Freeway",        
    "West Southwest Ft Worth",     
    "Westlake/Grapevine",      
    "White Rock",      
    "Wise County"]

    Submarket.destroy_all
    submarket_list.each { |n| Submarket.create(name: "#{n}" )}
    