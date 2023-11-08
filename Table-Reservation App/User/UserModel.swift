//
//  User.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//

import Foundation

struct UserModel: Decodable {
    var isAdmin: Bool?
    var firstName: String? 
    var lastName: String?
    var email: String?
    var  phoneNumber: String?
    var password: String?


    init?(jsonData: [String: Any]) {
            guard let isAdmin = jsonData["isAdmin"] as? Bool,
                  let firstName = jsonData["firstName"] as? String,
                  let lastName = jsonData["lastName"] as? String,
                  let email = jsonData["email"] as? String,
                  let phoneNumber = jsonData["phoneNumber"] as? String,
                  let password = jsonData["password"] as? String else {
                return nil // Return nil if any of the required fields is missing or of the wrong type
            }

            self.isAdmin = isAdmin
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.phoneNumber = phoneNumber
            self.password = password
        print("Parsed UserModel: \(self)")
        }

}
