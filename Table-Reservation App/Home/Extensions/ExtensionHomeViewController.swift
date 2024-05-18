
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

        contentView.addSubview(stackView1)
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(restaurantCardView)
        contentView.addSubview(reserveButton)
        contentView.addSubview(cartButton)
        contentView.addSubview(mapView)

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

            cartButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -5),
               cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               cartButton.widthAnchor.constraint(equalToConstant: 50),
               cartButton.heightAnchor.constraint(equalToConstant: 50),


            stackView1.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView1.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: 10),

            restaurantImageView.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            restaurantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restaurantImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            restaurantImageView.widthAnchor.constraint(equalTo: restaurantImageView.heightAnchor, multiplier: 16.0/9.0),

            restaurantCardView.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 20),
            restaurantCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restaurantCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            mapView.topAnchor.constraint(equalTo: restaurantCardView.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalTo: restaurantCardView.heightAnchor),


            reserveButton.topAnchor.constraint(equalTo:  mapView.bottomAnchor, constant: 20),
            reserveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}
