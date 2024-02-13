//
//  Components.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import Foundation
import SwiftUI

class UserCardView: UIView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .myBlue
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 2)

        setupImageView()
        setupStackView()
        setupLayout()
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 8

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .white
        nameLabel.textColor = .white

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),

            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(with name: String, email: String, image: UIImage) {
        nameLabel.text = name
        emailLabel.text = email
        imageView.image = image
    }
}
