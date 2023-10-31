//
//  LoginPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation

// Protocol to define methods for the presenter
protocol LoginPresenter {
    func bind(displayer: LoginDisplayer)
    func didTapLogin(with model: LoginModel)
    var delegate: LoginPresenterDelegate? { get set }
}

class LoginPresenterImpl: LoginPresenter {
    weak var displayer: LoginDisplayer?
    weak var delegate: LoginPresenterDelegate?

    func bind(displayer: LoginDisplayer) {
        self.displayer = displayer
    }

    func didTapLogin(with model: LoginModel) {

        // Construct a URL for the login endpoint

        guard let url = URL(string: "http://localhost:3000/auth/signin") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            delegate?.loginFailed(with: error)
            return
        }

        // Create an HTTP request for login

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare request parameters
        let parameters: [String: Any] = [
            "email": model.email,
            "password": model.password
        ]

        do {
            // Serialize parameters to JSON and set as request body

            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            let error = NSError(domain: "NetworkErrorDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request parameters"])
            delegate?.loginFailed(with: error)
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                self.delegate?.loginFailed(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.delegate?.loginFailed(with: error)
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let token = responseJSON?["jwt"] as? String {
                    delegate?.loginSuccessful(with: token)
                } else if let errorMessage = responseJSON?["jwt"] as? String {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    delegate?.loginFailed(with: error)
                } else {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
                    delegate?.loginFailed(with: error)
                }
            } catch {
                delegate?.loginFailed(with: error)
            }
        }

        task.resume()
    }

}
