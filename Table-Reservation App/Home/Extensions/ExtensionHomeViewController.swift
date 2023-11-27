
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

//    func setUpConstraints() {
//        let stackView1 = UIStackView(arrangedSubviews: [helloUserNameLabel, letsBookTableLabel])
//        stackView1.axis = .vertical
//        stackView1.alignment = .leading
//        stackView1.spacing = 10
//        stackView1.translatesAutoresizingMaskIntoConstraints = false
//
//        let stackView2 = UIStackView(arrangedSubviews: [whenPlanVisitLabel, datePicker])
//        stackView2.axis = .vertical
//        stackView2.alignment = .leading
//        stackView2.spacing = 10
//        stackView2.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView1)
//        view.addSubview(stackView2)
//
//        stackView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
//        stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10).isActive = true
//
//
//        datePicker.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20).isActive = true
//        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        NSLayoutConstraint.activate([
//            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
//            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
//            userProfileButton.heightAnchor.constraint(equalToConstant: 55)
//        ])
//    }

    func setUpConstraints() {
        let stackView1 = UIStackView(arrangedSubviews: [helloUserNameLabel, letsBookTableLabel])
        stackView1.axis = .vertical
        stackView1.alignment = .leading
        stackView1.spacing = 10
        stackView1.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView1)
        view.addSubview(whenPlanVisitLabel)
        view.addSubview(datePicker)

        stackView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView1.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 10).isActive = true


        whenPlanVisitLabel.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20).isActive = true
        whenPlanVisitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        whenPlanVisitLabel.trailingAnchor.constraint(equalTo: userProfileButton.leadingAnchor, constant: 30).isActive = true

        datePicker.topAnchor.constraint(equalTo: whenPlanVisitLabel.bottomAnchor, constant: 20).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            userProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userProfileButton.widthAnchor.constraint(equalToConstant: 55),
            userProfileButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

}
