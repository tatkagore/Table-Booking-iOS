//
//  CartManager.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 18/05/2024.
//

import Foundation

class CartManager {
    static let shared = CartManager()

    private init() {}

    var itemCount: Int = 0

    func addItem(quantity: Int) {
        itemCount += quantity
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func removeItem(quantity: Int) {
        if itemCount >= quantity {
            itemCount -= quantity
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }
}


extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}


/* MARK: Singleton Pattern: Ensures that there is only one instance of CartManager.
- tracks the total quantity of items in the cart
- itemCount: Stores the total quantity of items in the cart.
- addItem(quantity:): Adds a specified quantity to the cart and posts a notification.
- removeItem(quantity:): Removes a specified quantity from the cart (if possible) and posts a notification.
- NotificationCenter: Used to broadcast updates about the cart.
 */
