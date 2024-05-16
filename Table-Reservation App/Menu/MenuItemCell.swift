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
        label.textColor = .orange
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        priceBackgroundView.addSubview(priceLabel)
        contentView.addSubview(priceBackgroundView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(stepperValueLabel)
        contentView.isUserInteractionEnabled = true


        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),


            priceBackgroundView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            priceBackgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: priceBackgroundView.topAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: priceBackgroundView.bottomAnchor, constant: -4),
            priceLabel.leadingAnchor.constraint(equalTo: priceBackgroundView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: priceBackgroundView.trailingAnchor, constant: -8),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            stepper.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            stepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            stepperValueLabel.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 8),
            stepperValueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
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
}
