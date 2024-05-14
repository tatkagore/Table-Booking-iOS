//
//  LoginPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation
import UIKit

// Protocol to define methods for the presenter
protocol LoginPresenter {
    func bind(displayer: LoginDisplayer)
    func didTapLogin(with model: LoginModel)
    var delegate: LoginPresenterDelegate? { get set }
}

class LoginPresenterImpl: LoginPresenter {
    let navigationController: UINavigationController
    weak var displayer: LoginDisplayer?
    weak var delegate: LoginPresenterDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

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
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.delegate?.loginFailed(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self?.delegate?.loginFailed(with: error)
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                // Assuming authToken is received from the server upon successful login
                if let authToken = responseJSON?["jwt"] as? String {
                    // Call the loginSuccessful function with the received authToken and user
                    self?.saveToken(authToken: authToken)
                    self?.displayHome()
                } else if let errorMessage = responseJSON?["jwt"] as? String {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    self?.delegate?.loginFailed(with: error)
                } else {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
                    self?.delegate?.loginFailed(with: error)
                }
            } catch {
                self?.delegate?.loginFailed(with: error)
            }
        }

        task.resume()
    }

}

private extension LoginPresenterImpl {
    func displayHome() {
        DispatchQueue.main.async { [weak self] in
                guard let window = UIApplication.shared.windows.first else { return }
                let tabBarController = MainTabBarController() // Use your custom tab bar controller

                // Reset the root view controller to the tab bar controller
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            }
    }

    func saveToken(authToken: String){
        let authManager = KeychainHelper()
        do {
            try authManager.saveTokenToKeychain(token: authToken)
            // Log success
            print("Token saved to Keychain")
        } catch {
            // Handle the error if saving the token fails
            print("Error saving token to Keychain: \(error.localizedDescription)")
        }
    }
}
