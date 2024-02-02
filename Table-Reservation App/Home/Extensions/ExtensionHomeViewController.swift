
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
        let stackView1 = UIStackView(arrangedSubviews: [helloUserNameLabel, letsBookTableLabel])
        stackView1.axis = .vertical
        stackView1.alignment = .leading
        stackView1.spacing = 10
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        restaurantCardView.translatesAutoresizingMaskIntoConstraints = false

        let stackView2 = UIStackView(arrangedSubviews: [numOfPeopleLabel, customStepper])
        stackView2.axis = .horizontal
        stackView2.alignment = .leading
        stackView2.spacing = 30
        stackView2.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView1)
        view.addSubview(stackView2)
        view.addSubview(restaurantCardView)
        view.addSubview(whenPlanVisitLabel)
        view.addSubview(datePicker)
        view.addSubview(textField)
        view.addSubview(noteLabel)
        view.addSubview(reserveButton)

        NSLayoutConstraint.activate([

            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55),

            stackView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10),

            restaurantCardView.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            restaurantCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            restaurantCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            whenPlanVisitLabel.topAnchor.constraint(equalTo: restaurantCardView.bottomAnchor, constant: 20),
            whenPlanVisitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            datePicker.topAnchor.constraint(equalTo: whenPlanVisitLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView2.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            noteLabel.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 20),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            textField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalToConstant: 190),

            reserveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reserveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reserveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)

        ])
    }
}
