//
//  Reservation.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//

import Foundation

struct Reservation: Codable {
    var id: String? = nil
    var startReservation: TimeInterval
    var endReservation: TimeInterval
    var userId: String
    var tableId: String

    init(userId: String, tableId: String, startReservation: TimeInterval, endReservation: TimeInterval) {
        self.userId = userId
        self.tableId = tableId
        self.startReservation = startReservation
        self.endReservation = endReservation
    }
}
