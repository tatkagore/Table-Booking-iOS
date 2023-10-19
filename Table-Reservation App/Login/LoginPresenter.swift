//
//  LoginPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//


import Foundation


protocol LoginPresenter {
    func bind(displayer: LoginDisplayer)
    func login(with model: LoginModel, completion: @escaping (Result<String, Error>) -> Void)
}

class LoginPresenterImpl: LoginPresenter {
    weak var displayer: LoginDisplayer?

    func bind(displayer: LoginDisplayer) {
        self.displayer = displayer
    }

    func login(with model: LoginModel, completion: @escaping (Result<String, Error>) -> Void) {
        // Make a network request to your API to perform the login
        // You can use URLSession, Alamofire, or another networking library here

        // For demonstration purposes, we'll simulate a successful login
        if model.username == "your_username" && model.password == "your_password" {
            // Replace "your_username" and "your_password" with your actual validation logic
            completion(.success("Login successful"))
        } else {
            // Replace this with actual error handling and error messages from your API
            let error = NSError(domain: "LoginErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
            completion(.failure(error))
        }
    }
}
