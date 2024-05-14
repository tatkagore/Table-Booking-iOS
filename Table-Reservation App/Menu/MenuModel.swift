//
//  MenuModel.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 14/05/2024.
//

import Foundation

struct MenuItem {
    let name: String
    let description: String
    let price: Double
}

struct MenuCategory {
    let title: String
    let items: [MenuItem]
    let imageName: String
}
