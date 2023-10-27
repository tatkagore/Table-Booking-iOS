//
//  LoginPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation

protocol LoginPresenter {
    func bind(displayer: LoginDisplayer)
    func didTapLogin(with model: LoginModel)
}


class LoginPresenterImpl: LoginPresenter {
    weak var displayer: LoginDisplayer?

    func bind(displayer: LoginDisplayer) {
        self.displayer = displayer
    }

    func didTapLogin(with model: LoginModel) {
        guard let url = URL(string: "http://localhost:3000/auth/signin") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "email": model.email,
            "password": model.password
        ]  

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let token = responseJSON?["message"] as? String {
                } else if let errorMessage = responseJSON?["message"] as? String {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                } else {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
                }
            } catch {

            }
        }

        task.resume()
        let homeViewController = HomeViewController()
        self.displayer?.show(viewController: homeViewController)
    }
}
