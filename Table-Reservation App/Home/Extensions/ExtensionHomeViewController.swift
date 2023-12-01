
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

        view.addSubview(stackView1)
        view.addSubview(whenPlanVisitLabel)
        view.addSubview(datePicker)
        view.addSubview(textField)
        view.addSubview(noteLabel)
        view.addSubview(numOfPeopleLabel)
        view.addSubview(customStepper)


        stackView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10).isActive = true

        whenPlanVisitLabel.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20).isActive = true
        whenPlanVisitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -55).isActive = true
        whenPlanVisitLabel.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 30).isActive = true

        datePicker.topAnchor.constraint(equalTo: whenPlanVisitLabel.bottomAnchor, constant: 20).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        noteLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        textField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true

        numOfPeopleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        numOfPeopleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55)
        ])

        NSLayoutConstraint.activate([
            customStepper.topAnchor.constraint(equalTo: numOfPeopleLabel.bottomAnchor, constant: 20),
            customStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customStepper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customStepper.widthAnchor.constraint(equalToConstant: 150),
            customStepper.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
