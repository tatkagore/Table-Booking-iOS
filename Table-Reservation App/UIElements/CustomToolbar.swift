//
//  CustomToolbar.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/10/2023.
//
import UIKit

class CustomToolbar: UIToolbar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupToolbar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupToolbar()
    }

    private func setupToolbar() {
        // Set up constraints for the toolbar
        self.translatesAutoresizingMaskIntoConstraints = false

        // Create the left button with a larger size
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle.fill"), style: .plain, target: self, action: #selector(leftButtonTapped))
        leftButton.tintColor = UIColor(red: 0xF4/255.0, green: 0xA2/255.0, blue: 0x61/255.0, alpha: 1.0)
        leftButton.width = 50.0

        // Create the right button with a smaller size
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.circle.fill"), style: .plain, target: self, action: #selector(rightButtonTapped))
        rightButton.tintColor = UIColor(red: 0xF4/255.0, green: 0xA2/255.0, blue: 0x61/255.0, alpha: 1.0)
        rightButton.width = 30.0

        // Set the background color for the toolbar
        self.barTintColor = UIColor(red: 0xF4/255.0, green: 0xA2/255.0, blue: 0x61/255.0, alpha: 1.0)

        // Add buttons to the toolbar
        self.items = [leftButton, UIBarButtonItem.flexibleSpace(), rightButton]
    }

    @objc private func leftButtonTapped() {
        print("Left Button tapped!")
    }

    @objc private func rightButtonTapped() {
        print("Right Button tapped!")
    }
}

