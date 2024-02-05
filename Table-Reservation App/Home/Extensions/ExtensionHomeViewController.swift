
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

        contentView.addSubview(stackView1)
        contentView.addSubview(stackView2)
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(restaurantCardView)
        contentView.addSubview(whenPlanVisitLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(textField)
        contentView.addSubview(noteLabel)
        contentView.addSubview(reserveButton)
        contentView.addSubview(userProfileButton)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            userProfileButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55),

            stackView1.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10),

            restaurantImageView.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            restaurantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restaurantImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            restaurantImageView.widthAnchor.constraint(equalTo: restaurantImageView.heightAnchor, multiplier: 16.0/9.0),

            restaurantCardView.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 20),
            restaurantCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restaurantCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            whenPlanVisitLabel.topAnchor.constraint(equalTo: restaurantCardView.bottomAnchor, constant: 20),
            whenPlanVisitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            datePicker.topAnchor.constraint(equalTo: whenPlanVisitLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView2.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            noteLabel.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 20),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            textField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalToConstant: 190),

            //            reserveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            reserveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            reserveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            //            reserveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)

        ])
    }
}
