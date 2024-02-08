//
//  AuthenticationManager.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 03/11/2023.
//

import UIKit
import Security

class KeychainHelper {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    func saveTokenToKeychain(token: String) throws {
        // Ensure the token is not empty
        guard !token.isEmpty else {
            throw KeychainError.unknown(errSecSuccess)
        }
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "Table-Reservation-App-Token" as AnyObject,
            kSecValueData as String: token.data(using: .utf8)! as AnyObject
        ]
        
        // Delete any existing token with the same identifier (optional)
        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus != errSecSuccess && deleteStatus != errSecItemNotFound {
            throw KeychainError.unknown(deleteStatus)
        }
        
        // Add the new token to the Keychain
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        if addStatus != errSecSuccess {
            throw KeychainError.unknown(addStatus)
        }
    }
    
    func getTokenFromKeychain() -> String? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "Table-Reservation-App-Token" as AnyObject,
            kSecReturnData as String: true as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let tokenData = result as? Data, let token = String(data: tokenData, encoding: .utf8) {
            return token
        } else {
            return nil
        }
    }
    
    func logout() {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "Table-Reservation-App-Token" as AnyObject
        ]
        
        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus == errSecSuccess || deleteStatus == errSecItemNotFound {
            print("Token removed successfully.")
        } else {
            print("Error removing token: \(deleteStatus)")
        }
    }
    
}


/* Here's how the flow works:
 - The user enters their credentials (e.g., email and password) in the login screen.
 - When the user taps the "Login" button, your app sends a request to your server or authentication service for user authentication.
 - If the authentication is successful, the server responds with an authentication token (e.g., a JSON Web Token or JWT).
 - In the didTapLogin method of your LoginPresenter, you receive this authentication token as part of the server response.
 - You then call the loginSuccessful method with the received authentication token and other user data.
 */
