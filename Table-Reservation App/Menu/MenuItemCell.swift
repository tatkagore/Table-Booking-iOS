//
//  MenuItemCell.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 15/05/2024.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let priceBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.myGreen
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .gray
        return label
    }()

    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()

    private let stepperValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "1"
        return label
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .myGreen
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor

        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, descriptionLabel, stepperValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        contentView.addSubview(stepper)
        contentView.addSubview(addButton)
        stackView.addSubview(priceBackgroundView)
        priceBackgroundView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            priceBackgroundView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            priceBackgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: priceBackgroundView.topAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: priceBackgroundView.bottomAnchor, constant: -4),
            priceLabel.leadingAnchor.constraint(equalTo: priceBackgroundView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: priceBackgroundView.trailingAnchor, constant: -8),

            imageView.heightAnchor.constraint(equalToConstant: 150),

            stepper.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            stepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            addButton.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: MenuItem) {
        nameLabel.text = item.name
        priceLabel.text = "€\(item.price)"
        imageView.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.description
    }

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        stepperValueLabel.text = "\(Int(sender.value))"
    }

   //MARK: Updates the cart with the quantity specified by a stepper.

    @objc private func addButtonTapped() {
        print("Added to cart")

        // Get the quantity from the stepper
        let quantity = Int(stepper.value)

        // Update the cart count with the quantity
        CartManager.shared.addItem(quantity: quantity)

        // Reset the stepper to 1 after adding to the cart
        stepper.value = 1
        stepperValueLabel.text = "1"

        UIView.animate(withDuration: 0.1, animations: {
            self.addButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.addButton.backgroundColor = UIColor.darkGray
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.addButton.transform = CGAffineTransform.identity
                self.addButton.backgroundColor = UIColor.myGreen
            }
        }
    }
}
