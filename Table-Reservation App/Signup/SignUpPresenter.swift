//
//  SignupPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 02/11/2023.
//

import Foundation


// Protocol to define methods for the presenter
protocol SignUpPresenter {
    func bind(displayer: SignUpDisplayer)
    func didTapSignUp(with model: SignUpModel)
    var delegate: SignUpPresenterDelegate? { get set }
}

class SignUpPresenterImpl: SignUpPresenter {

    weak var displayer: SignUpDisplayer?
    weak var delegate: SignUpPresenterDelegate?

    func bind(displayer: SignUpDisplayer) {
        self.displayer = displayer
    }
    
    func didTapSignUp(with model: SignUpModel) {
        
        // Construct a URL for the login endpoint

        guard let url = URL(string: "http://localhost:3000/auth/signup") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            delegate?.signUpFailed(with: error)
            return
        }

        // Create an HTTP request for login

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

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
            delegate?.signUpFailed(with: error)
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                self.delegate?.signUpFailed(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.delegate?.signUpFailed(with: error)
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let token = responseJSON?["message"] as? String {
                    delegate?.signUpSuccessful()
                } else if let errorMessage = responseJSON?["message"] as? String {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    delegate?.signUpFailed(with: error)
                } else {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
                    delegate?.signUpFailed(with: error)
                }
            } catch {
                delegate?.signUpFailed(with: error)
            }
        }

        task.resume()
    }



}

