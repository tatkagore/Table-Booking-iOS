//
//  ReservationsModel.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import Foundation

struct ReservationModel: Codable {
    let id: Int
    let date: String
    let note: String
    let numberOfGuests: Int
    let userId: Int
    let createdAt: String
    let updatedAt: String

}

extension ReservationModel {
    init?(jsonData: [String: Any]) {
        guard let id = jsonData["id"] as? Int,
              let date = jsonData["date"] as? String,
              let note = jsonData["note"] as? String,
              let numberOfGuests = jsonData["numberOfGuests"] as? Int,
              let userId = jsonData["userId"] as? Int,
              let createdAt = jsonData["createdAt"] as? String,
              let updatedAt = jsonData["updatedAt"] as? String else {
            return nil
        }

        self.id = id
        self.date = date
        self.note = note
        self.numberOfGuests = numberOfGuests
        self.userId = userId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct ReservationsResponse: Codable {
    let reservations: [ReservationModel]
}
