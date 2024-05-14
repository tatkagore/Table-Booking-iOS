//
//  StyledButton.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//

import UIKit

class StyledButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }

    private func setStyle() {

        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(hex: "006400") // Set background color to #E9C46A
        self.layer.cornerRadius = 5.0 // Add rounded corners with a radius of 10
        self.layer.borderColor = UIColor(hex: "334195").cgColor // Set border color to #F4A261
        self.layer.borderWidth = 1.0 // Increase border width
        self.titleLabel?.font = UIFont(name: "Print Clearly", size: 30)
        self.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        // Add shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3) // Adjust shadow offset as needed
        self.layer.shadowOpacity = 0.5 // Adjust shadow opacity as needed
        self.layer.shadowRadius = 3.0 // Adjust shadow radius as needed
        self.layer.masksToBounds = false
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class profileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }

    private func setStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16 // Set the corner radius as needed

        // Add shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3) // Adjust shadow offset as needed
        self.layer.shadowOpacity = 0.5 // Adjust shadow opacity as needed
        self.layer.shadowRadius = 3.0 // Adjust shadow radius as needed
        self.layer.masksToBounds = false
    }

}

class MyAccountButton: UIButton {

    private let titleAndSubtitleContainer = UIView()
    private let customTitleLabel = UILabel()
    private let customSubtitleLabel = UILabel()
    var onRightButtonTapped: (() -> Void)?
    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // Basic button setup
        backgroundColor = .white
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor(hex: "334195").cgColor
        layer.borderWidth = 1.0

        // Add container view
        addSubview(titleAndSubtitleContainer)
        titleAndSubtitleContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleAndSubtitleContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleAndSubtitleContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleAndSubtitleContainer.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            titleAndSubtitleContainer.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
        ])

        // Custom title label setup
        customTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        customTitleLabel.textColor = .black
        titleAndSubtitleContainer.addSubview(customTitleLabel)
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Subtitle label setup
        customSubtitleLabel.font = UIFont.systemFont(ofSize: 14)
        customSubtitleLabel.textColor = .darkGray
        titleAndSubtitleContainer.addSubview(customSubtitleLabel)
        customSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Layout for custom title and subtitle labels
        NSLayoutConstraint.activate([
            customTitleLabel.topAnchor.constraint(equalTo: titleAndSubtitleContainer.topAnchor),
            customTitleLabel.leadingAnchor.constraint(equalTo: titleAndSubtitleContainer.leadingAnchor),
            customTitleLabel.trailingAnchor.constraint(equalTo: titleAndSubtitleContainer.trailingAnchor),

            customSubtitleLabel.topAnchor.constraint(equalTo: customTitleLabel.bottomAnchor, constant: 2),
            customSubtitleLabel.leadingAnchor.constraint(equalTo: titleAndSubtitleContainer.leadingAnchor),
            customSubtitleLabel.trailingAnchor.constraint(equalTo: titleAndSubtitleContainer.trailingAnchor),
            customSubtitleLabel.bottomAnchor.constraint(equalTo: titleAndSubtitleContainer.bottomAnchor)
        ])

        // Shadow setup
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3.0
        layer.masksToBounds = false

        // Padding around content
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    // MARK: Custom icon and text setup

    func setIcons(leftIcon: UIImage?, rightIcon: UIImage?, title: String?, subtitle: String?) {
        customTitleLabel.text = title
        customSubtitleLabel.text = subtitle
        let iconSize: CGFloat = 30

        // Set left icon
        if let leftImage = leftIcon {
            let leftIconView = UIImageView(image: leftImage.withRenderingMode(.alwaysOriginal))
            leftIconView.contentMode = .scaleAspectFit
            addSubview(leftIconView)
            leftIconView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                leftIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                leftIconView.widthAnchor.constraint(equalToConstant: iconSize),
                leftIconView.heightAnchor.constraint(equalToConstant: iconSize),
                titleAndSubtitleContainer.leadingAnchor.constraint(equalTo: leftIconView.trailingAnchor, constant: 10)
            ])
        } else {
            NSLayoutConstraint.activate([
                titleAndSubtitleContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            ])
        }

        // Set right icon (if necessary)
        if let rightImage = rightIcon {
            let rightButton = UIButton(type: .system)
            rightButton.setImage(rightImage.withRenderingMode(.alwaysOriginal), for: .normal)
            rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
            addSubview(rightButton)
            rightButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                rightButton.widthAnchor.constraint(equalToConstant: 30),
                rightButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
    }

    @objc private func rightButtonTapped() {
            onRightButtonTapped?()
        }
}
