//
//  ReservationsListsPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import Foundation

protocol ReservationsListPresenter {
    func bind(displayer: ReservationsListDisplayer)
    func onViewDidLoad()
    var delegate: ReservationsListPresenterDelegate? { get set }
}

class ReservationsListsPresenterImpl: ReservationsListPresenter {
    weak var delegate: ReservationsListPresenterDelegate?
    weak var displayer: ReservationsListDisplayer?

    func bind(displayer: ReservationsListDisplayer) {
        self.displayer = displayer
    }

    func onViewDidLoad() {
        // Construct a URL for the Reservations endpoint

        guard let url = URL(string: "http://localhost:3000/api/reservation/me") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            displayer?.showError(error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let keychain = KeychainHelper()
        let token = keychain.getTokenFromKeychain()
        request.setValue(token, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in

            if let error = error {
                displayer?.showError(error)
                return
            }

            guard let data = data else {
                displayer?.showError(APIError.invalidData)
                return
            }
            do {
                // Parse the JSON response
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let jsonData = jsonData?["reservations"] as? [[String: Any]] {
                    var reservations = [ReservationModel]()
                    for reservationDict in jsonData {
                        if let reservation = ReservationModel(jsonData: reservationDict) {
                            reservations.append(reservation)
                        }
                    }
                    displayer?.showReservations(reservations)
                } else {
                    displayer?.showError(APIError.unknownError)
                }

            } catch {
                displayer?.showError(APIError.unknownError)
            }
        }
        task.resume()
    }
}
