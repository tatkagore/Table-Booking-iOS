//
//  HomePresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 07/11/2023.
//

import Foundation

protocol HomePresenter {
    func bind(displayer: HomeDisplayer)
    func onViewDidLoad()
}

class HomePresenterImpl: HomePresenter {
    weak var displayer: HomeDisplayer?
    var delegate: HomePresenterDelegate?

    func bind(displayer: HomeDisplayer) {
        self.displayer = displayer
    }
    func onViewDidLoad() {
        // Construct a URL for the user endpoint
        guard let url = URL(string: "http://localhost:3000/api/user/me") else {
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


        // Perform the network request using URLSession
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
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let userJSON = responseJSON?["currentUser"] as? [String: Any] {
                    // Parse the user data
                    if let user = UserModel(jsonData: userJSON) {
                        displayer?.showUser(user)
                    } else {
                        displayer?.showError(APIError.unknownError)
                    }
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
