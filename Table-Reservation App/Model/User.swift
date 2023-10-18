//
//  User.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//

import Foundation

struct User: Codable {
    var id: String? = nil
    var name: String
    var phone: String
    init(name: String, phone: String){
        self.name = name
        self.phone = phone
    }
}
