//
//  Model.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//

import Foundation


struct Restaurant {
    var name: String
    var address: String
    var cuisine: String
    var rating: Double
}

// Create some example restaurant data
let restaurantData: [Restaurant] = [
    Restaurant(name: "Restaurant A", address: "123 Main St", cuisine: "Italian", rating: 4.5),
    Restaurant(name: "Restaurant B", address: "456 Elm St", cuisine: "Japanese", rating: 4.0),
    Restaurant(name: "Restaurant C", address: "789 Oak St", cuisine: "Mexican", rating: 4.2),
    Restaurant(name: "Restaurant D", address: "101 Pine St", cuisine: "French", rating: 4.8)
]
