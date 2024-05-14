//
//  HomeViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import UIKit
import MapKit

protocol HomeDisplayer: AnyObject {
    func showUser(_ user: UserModel)
    func showError(_ error: Error)
}

protocol HomePresenterDelegate: AnyObject {
}

class HomeViewController: UIViewController, HomePresenterDelegate, CLLocationManagerDelegate {
    var isMapFullScreen = false
    var originalMapConstraints: [NSLayoutConstraint] = []

    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    var presenter: HomePresenter = HomePresenterImpl()
    var restaurantCardView = RestaurantCardView()
    var user: UserModel?

    let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Cafe")
        return imageView
    }()

    var helloUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.myGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var letsBookTableLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's book a table!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.myGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var userProfileButton: profileButton = {
        let button = profileButton()
        // Set the image for the button
        let buttonImage = UIImage(named: "avatar")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(userProfileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var reserveButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Let's Book!", for: .normal)
        button.addTarget(self, action: #selector(reserveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Create a UIScrollView
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false

        presenter.bind(displayer: self)
        setUpConstraints()
        presenter.onViewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleMapSize))
        mapView.addGestureRecognizer(tapRecognizer)
        centerMapOnLocation(address: "79 Av. Bosquet, 75007 Paris")
    }
//
    @objc func userProfileButtonTapped() {
//        let presenter = ReservationsListsPresenterImpl(navigationController: self.navigationController!)
//        let reservationsListViewController = ReservationsListViewController(presenter: presenter, user: user)
//        self.navigationController?.pushViewController(reservationsListViewController, animated: true)
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.user = user
        self.navigationController?.pushViewController(userProfileViewController, animated: true)
    }

    @objc func reserveButtonTapped() {
        let reservationViewController = ReservationViewController(user: user)
        // Modal presentation style
        self.present(UINavigationController(rootViewController: reservationViewController), animated: true, completion: nil)
    }
}

extension HomeViewController: HomeDisplayer {
    func showError(_ error: Error) {
        print("User data fetching error: \(error.localizedDescription)")
    }

    func showUser(_ user: UserModel) {
        // Update the UI on the main thread
        DispatchQueue.main.async { [weak self] in
            print(user)
            self?.user = user
            if let firstName = user.firstName {
                self?.helloUserNameLabel.text = "Welcome, \(firstName)"
            }
        }
    }
}
