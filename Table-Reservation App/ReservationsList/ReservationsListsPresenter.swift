//
//  ReservationsListsPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import UIKit

protocol ReservationsListPresenter {
    func bind(displayer: ReservationsListDisplayer)
    func onViewDidLoad()
    func  deleteReservation(with reservation: ReservationModel)
    func fetchReservationsOfCurrentUser()
    var delegate: ReservationsListPresenterDelegate? { get set }
}

class ReservationsListsPresenterImpl: ReservationsListPresenter {
    let navigationController: UINavigationController
    weak var displayer: ReservationsListDisplayer?
    weak var delegate: ReservationsListPresenterDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func bind(displayer: ReservationsListDisplayer) {
        self.displayer = displayer
    }

    //MARK: onViewDidLoad

    func onViewDidLoad() {
        fetchReservationsOfCurrentUser()
    }

    //MARK: fetchReservationsOfCurrentUser

    func fetchReservationsOfCurrentUser() {
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
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]

                if let jsonData = jsonData
                {
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

    //MARK: deleteReservation

    func  deleteReservation(with reservation: ReservationModel) {

        guard let url = URL(string: "http://localhost:3000/api/reservation/\(reservation.id)") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            displayer?.showError(error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let keychain = KeychainHelper()
        let token = keychain.getTokenFromKeychain()
        request.setValue(token, forHTTPHeaderField: "Authorization")


        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.displayer?.showError(error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { [weak self] in
                    self?.displayer?.showError(APIError.invalidData)
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let deletionResponse = try decoder.decode(DeletionResponse.self, from: data)
                if deletionResponse.message == "Reservation deleted." {
                    self.fetchReservationsOfCurrentUser()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.displayer?.showError(APIError.unknownError )
                    }
                }
            }
            catch {
                print("Unexpected error: \(error).")
                DispatchQueue.main.async { [weak self] in
                    self?.displayer?.showError(APIError.authenticationError)
                }
            }
        }
        task.resume()
    }
}

