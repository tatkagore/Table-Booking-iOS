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
//            completion(.failure(error))
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
//            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
//                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
//                completion(.failure(error))
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let token = responseJSON?["message"] as? String {
//                    completion(.success(token))
                } else if let errorMessage = responseJSON?["message"] as? String {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                    completion(.failure(error))
                } else {
                    let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid response from the server"])
//                    completion(.failure(error))
                }
            } catch {
//                completion(.failure(error))
            }
        }

        task.resume()
    }
}
