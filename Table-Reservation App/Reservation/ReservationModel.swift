//
//  ReservationModel.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 05/02/2024.
//

import Foundation

struct ReservationModel: Codable {
    let date: Date
    let numberOfGuests: Int
    let note: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case date
        case numberOfGuests
        case note
        case userId
    }
}
