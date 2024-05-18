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

    var cartButton: UIButton = {
        let button = UIButton()

        let buttonImage = UIImage(systemName: "cart")

        // set the size of the image
        let imageView = UIImageView(image: buttonImage)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        button.addSubview(imageView)

        // Position the imageView within the button
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])

        button.addTarget(self, action: #selector(userProfileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        // Add badge label
        let badgeLabel = UILabel()
        badgeLabel.text = "0"
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .red
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(badgeLabel)

        // badge constraints
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: -5),
            badgeLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 7),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

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

    //MARK: OnViewDidLoad
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

        //MARK: Updates the badge count on the cart button whenever the cart is updated.
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
    }

    @objc func userProfileButtonTapped() {
        let presenter = OrderPresenterImpl()
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }

    @objc func reserveButtonTapped() {
        let reservationViewController = ReservationViewController(user: user)
        // Modal presentation style
        self.present(UINavigationController(rootViewController: reservationViewController), animated: true, completion: nil)
    }

    @objc func cartUpdated() {
        let itemCount = CartManager.shared.itemCount
        updateBadgeCount(to: itemCount)
    }

    func updateBadgeCount(to count: Int) {
        for subview in cartButton.subviews {
            if let badgeLabel = subview as? UILabel {
                badgeLabel.text = "\(count)"
                break
            }
        }
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
