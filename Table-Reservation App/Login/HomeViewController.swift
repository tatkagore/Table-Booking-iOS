//
//  HomeViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    var welcomeMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let welcomeLabel = UILabel()
        welcomeLabel.text = welcomeMessage
        
    }
}
