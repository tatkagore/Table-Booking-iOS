//
//  InformationCardView.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 01/02/2024.
//
import Foundation
import SwiftUI

class RestaurantCardView: UIView {
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let cuisineLabel = UILabel()
    private let addressLabel = UILabel()

    private let starIconView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.yellow))
    private let pinIconView = UIImageView(image: UIImage(systemName: "mappin.and.ellipse")?.withTintColor(.red))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        styleCard()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        styleCard()
    }

    private func setupViews() {
        addSubview(nameLabel)
        addSubview(ratingLabel)
        addSubview(cuisineLabel)
        addSubview(addressLabel)
        addSubview(starIconView)
        addSubview(pinIconView)

        // Configure and style the labels and icons
        configureLabels()
        configureIcons()

        // Setup constraints
        setupConstraints()
    }

    private func configureLabels() {
        nameLabel.text = "Kozy"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = UIColor.myGreen

        ratingLabel.text = "4.8 (5200 reviews)"
        ratingLabel.font = UIFont.systemFont(ofSize: 16)

        cuisineLabel.text = "Restaurants Brunch\nCoffee shop & Smoothies ☕️ 🍹"
        cuisineLabel.font = UIFont.systemFont(ofSize: 16)
        cuisineLabel.numberOfLines = 0

        addressLabel.text = "79 Avenue Bosquet - 75007 - Paris"
        addressLabel.font = UIFont.systemFont(ofSize: 16)
    }

    private func configureIcons() {
        starIconView.tintColor = .systemYellow
        pinIconView.tintColor = UIColor.myGreen
    }

    private func styleCard() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        backgroundColor = .white
    }

    private func setupConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            starIconView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            starIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            starIconView.widthAnchor.constraint(equalToConstant: 20),
            starIconView.heightAnchor.constraint(equalToConstant: 20),

            ratingLabel.centerYAnchor.constraint(equalTo: starIconView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starIconView.trailingAnchor, constant: 8),

            cuisineLabel.topAnchor.constraint(equalTo: starIconView.bottomAnchor, constant: 8),
            cuisineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cuisineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            pinIconView.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 8),
            pinIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pinIconView.widthAnchor.constraint(equalToConstant: 20),
            pinIconView.heightAnchor.constraint(equalToConstant: 20),

            addressLabel.centerYAnchor.constraint(equalTo: pinIconView.centerYAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: pinIconView.trailingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
