//
//  RestaurantsPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 19/10/2023.
//

import Foundation

protocol RestaurantsPresenter {
    func bind(displayer: RestaurantsDisplayer)
    func onViewDidLoad()
}

class RestaurantsPresenterImpl: RestaurantsPresenter {
    // MARK: - Properties
    weak var displayer: RestaurantsDisplayer?

    // MARK: - RestaurantsPresenter
    func bind(displayer: RestaurantsDisplayer) {
        self.displayer = displayer
    }

    func onViewDidLoad() {

        let restaurants: [Restaurant] = [
            Restaurant(name: "Restaurant Italian", address: "123 Main St", cuisine: "Italian", rating: 4.5),
            Restaurant(name: "Restaurant Japanese", address: "456 Elm St", cuisine: "Japanese", rating: 4.0),
            Restaurant(name: "Restaurant Mexican", address: "789 Oak St", cuisine: "Mexican", rating: 4.2),
        ]
        displayer?.setup(viewModel: restaurants)
    }
}
