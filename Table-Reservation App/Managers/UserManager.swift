//
//  UserManager.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 14/05/2024.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {}

    var currentUser: UserModel?

    func fetchUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        // Construct a URL for the user endpoint
        guard let url = URL(string: "http://localhost:3000/api/user/me") else {
            let error = NSError(domain: "NetworkErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])
            completion(.failure(error))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let keychain = KeychainHelper()
        let token = keychain.getTokenFromKeychain()
        request.setValue(token, forHTTPHeaderField: "Authorization")


        // Perform the network request using URLSession
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                print("No data received")
                completion(.failure(error))
                return
            }

            do {
                // Parse the JSON response
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Response JSON: \(String(describing: responseJSON))")

                if let userJSON = responseJSON?["currentUser"] as? [String: Any],
                   let user = UserModel(jsonData: userJSON) {
                    self?.currentUser = user
                    completion(.success(user))
                } else {
                    let error = NSError(domain: "NetworkErrorDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid user data"])
                    print("Invalid user data")
                    completion(.failure(error))
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
