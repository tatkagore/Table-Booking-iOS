//
//  OrderViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 17/05/2024.
//

import UIKit

protocol OrderDisplayer: AnyObject {
    func showMenu(with categories: [MenuCategory])
}

class OrderViewController: UIViewController {
    var presenter: OrderPresenter = OrderPresenterImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Orders"
    }
}
