//
//  ReservationPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 05/02/2024.
//

import Foundation

// Protocol to define methods for the presenter
protocol ReservationPresenter {
    func bind(displayer: ReservationDisplayer)
    func didTapReserve(with model: ReservationModel)
    var delegate: ReservationPresenterDelegate? { get set }
}
class ReservationPresenterImpl: ReservationPresenter {
    weak var displayer: ReservationDisplayer?
    weak var delegate: ReservationPresenterDelegate?

    func bind(displayer: ReservationDisplayer) {
        self.displayer = displayer
    }

    func didTapReserve(with model: ReservationModel) {
        // Construct a URL for the reservation endpoint
        guard let url = URL(string: "http://localhost:3000/api/reservation") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            delegate?.reservationFailed(with: error)
            return
        }

        // Create an HTTP request for reservation

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let keychain = KeychainHelper()
        let token = keychain.getTokenFromKeychain()
        request.setValue(token, forHTTPHeaderField: "Authorization")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: model.date)

        // Prepare request parameters
        let parameters: [String: Any] = [
            "date": dateString,
            "numberOfGuests": model.numberOfGuests,
            "note": model.note,
            "userId": model.userId
        ]

        do {
            // Serialize parameters to JSON and set as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            let error = NSError(domain: "NetworkErrorDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request parameters"])
            delegate?.reservationFailed(with: error)
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                self.delegate?.reservationFailed(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.delegate?.reservationFailed(with: error)
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let authToken = responseJSON?["reservation"] as? [String: Any] {
                    delegate?.reservationSuccessful()
                } else {
                    let error = NSError(domain: "ReservationErrorDomain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
                    delegate?.reservationFailed(with: error)
                }
            } catch {
                delegate?.reservationFailed(with: error)
            }
        }
        task.resume()
    }
}
