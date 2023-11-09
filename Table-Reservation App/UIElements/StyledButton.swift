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
        self.backgroundColor = UIColor(hex: "334195") // Set background color to #E9C46A
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
