//
//  UserPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation

// Protocol to define methods for the presenter
protocol UserPresenter {
    func bind(displayer: UserProfileDisplayer)
    func didTapUpdate(with model: UserModel)
    var delegate: UserProfilePresenterDelegate? { get set }
}

class UserPresenterImpl: UserPresenter {

    weak var displayer: UserProfileDisplayer?
    weak var delegate: UserProfilePresenterDelegate?

    func bind(displayer: UserProfileDisplayer) {
        self.displayer = displayer
    }

    func didTapUpdate(with model: UserModel) {

        // Construct a URL for the User Update endpoint

        guard let url = URL(string: "http://localhost:3000/api/user/\(model.id!)") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            displayer?.updateFailed(with: error)
            return
        }

        // Create an HTTP request for login

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let keychain = KeychainHelper()
        let token = keychain.getTokenFromKeychain()
        request.setValue(token, forHTTPHeaderField: "Authorization")

        // Prepare request parameters
        let parameters: [String: Any] = [
            "firstName" : model.firstName,
            "password" : model.password,
            "lastName":  model.lastName,
            "email": model.email,
            "phoneNumber": model.phoneNumber

        ]

        do {
            // Serialize parameters to JSON and set as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            let error = NSError(domain: "NetworkErrorDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request parameters"])
            displayer?.updateFailed(with: error)
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                displayer?.updateFailed(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.displayer?.updateFailed(with: error)
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let userJSON = responseJSON?["user"] as? [String: Any] {

                    if let user = UserModel(jsonData: userJSON) {
                        ////        DispatchQueue.main.async { [weak self] in
                        //                        DispatchQueue.main.async {} to make all uievents into main thread
                        displayer?.updateSuccessful(with: user)
                        displayer?.showMessageSuccessful(with: "Update is Successful")
                    } else {
                        displayer?.updateFailed(with: APIError.unknownError)
                    }
                } else {

                    displayer?.updateFailed(with: APIError.unknownError)
                }
            } catch {
                displayer?.updateFailed(with: APIError.unknownError)
            }
        }
        task.resume()
    }

}
