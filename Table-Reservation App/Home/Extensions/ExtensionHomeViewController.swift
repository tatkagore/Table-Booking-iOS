
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

        // Constraints for logOutButton (centered)
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 280), // Adjust the width as needed
            logOutButton.heightAnchor.constraint(equalToConstant: 40) // Adjust the height as needed
        ])

        // Constraints for helloUserNameLabel (top of the screen, left with some spacing)

        NSLayoutConstraint.activate([
            helloUserNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16), // Adjust the top spacing as needed
            helloUserNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20) // Adjust the left spacing as needed
        ])

        // Constraints for userProfileButton to place it in the top-right corner
        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5), // Adjust the top spacing as needed
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // Adjust the right spacing as needed
            userProfileButton.widthAnchor.constraint(equalToConstant: 55), // Adjust the button's width
            userProfileButton.heightAnchor.constraint(equalToConstant: 55) // Adjust the button's height
        ])
    }
}


