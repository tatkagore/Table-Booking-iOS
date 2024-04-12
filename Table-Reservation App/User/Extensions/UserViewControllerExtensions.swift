//
//  UserViewControllerExtensions.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/11/2023.
//

import Foundation
import UIKit

extension UserProfileViewController {
    // MARK: - Auto Layout

    func setUpConstraints() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let stackTopView = UIStackView(arrangedSubviews: [userImageView])
        stackTopView.axis = .vertical
        stackTopView.spacing = 10
        stackTopView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, phoneNumberTextField, updateAccountButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let bottomStackView = UIStackView(arrangedSubviews: [logOutButton])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 20
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackTopView)
        contentView.addSubview(stackView)
        contentView.addSubview(serverResponceLabel)
        contentView.addSubview(bottomStackView)

        let namesContainerView = UIView()
        namesContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(namesContainerView)

        namesContainerView.addSubview(nameLabel)

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

            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userImageView.widthAnchor.constraint(equalToConstant: 100), 
            userImageView.heightAnchor.constraint(equalToConstant: 56),

            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            

            serverResponceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            serverResponceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            serverResponceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            bottomStackView.topAnchor.constraint(equalTo: serverResponceLabel.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }
}
