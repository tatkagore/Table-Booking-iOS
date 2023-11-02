
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
                   logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                   logOutButton.widthAnchor.constraint(equalToConstant: 280), // Adjust the width as needed
                   logOutButton.heightAnchor.constraint(equalToConstant: 60)  // Adjust the height as needed

               ])
    }
}


