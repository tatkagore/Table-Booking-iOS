//
//  ReservationModel.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 05/02/2024.
//

import Foundation

struct ReservationModel: Codable {
    let id: Int?
    let spotId: Int
    let date: Date
    let name: String
    let note: String
    let status: Int
    let userId: Int
    let roomId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case spotId
        case date
        case name
        case note
        case status
        case userId
        case roomId
    }
}
