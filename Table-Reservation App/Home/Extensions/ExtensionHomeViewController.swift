
//
//  Extensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 02/11/2023.
//

import Foundation
import UIKit

extension HomeViewController {
    // MARK: - Auto Layout

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            helloUserNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            helloUserNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
