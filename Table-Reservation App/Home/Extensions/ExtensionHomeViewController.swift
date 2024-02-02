
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

        view.addSubview(stackView1)
        view.addSubview(restaurantCardView)
        view.addSubview(whenPlanVisitLabel)
        view.addSubview(datePicker)
        view.addSubview(textField)
        view.addSubview(noteLabel)
        view.addSubview(numOfPeopleLabel)
        view.addSubview(customStepper)
        view.addSubview(reserveButton)

        NSLayoutConstraint.activate([

            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55),

            stackView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            //        stackView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10),

            restaurantCardView.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            restaurantCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            restaurantCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            whenPlanVisitLabel.topAnchor.constraint(equalTo: restaurantCardView.bottomAnchor, constant: 20),
            whenPlanVisitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            datePicker.topAnchor.constraint(equalTo: whenPlanVisitLabel.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            noteLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            textField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.widthAnchor.constraint(equalToConstant: 200),

            numOfPeopleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            numOfPeopleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            customStepper.topAnchor.constraint(equalTo: numOfPeopleLabel.bottomAnchor, constant: 20),
            customStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customStepper.widthAnchor.constraint(equalToConstant: 150),
            customStepper.heightAnchor.constraint(equalToConstant: 50),

            reserveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reserveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reserveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)

        ])


    }

}
