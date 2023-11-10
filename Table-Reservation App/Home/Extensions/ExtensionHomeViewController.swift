
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
        let stackView = UIStackView(arrangedSubviews: [helloUserNameLabel, letsBookTableLabel, datePicker])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(datePicker)

        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10).isActive = true

        datePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
