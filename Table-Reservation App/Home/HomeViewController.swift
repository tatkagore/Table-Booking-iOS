//
//  HomeViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 20/10/2023.
//

import UIKit

protocol HomeDisplayer: AnyObject {
    func showUser(_ user: UserModel)
    func showError(_ error: Error)
}

protocol HomePresenterDelegate: AnyObject {
}

class HomeViewController: UIViewController, HomePresenterDelegate {
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
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var letsBookTableLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's book a table!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var whenPlanVisitLabel: UILabel = {
        let label = UILabel()
        label.text = "Chose date and time"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.myBlue
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

    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()

    var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Additional information for booking"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type here..."
        textField.textColor = .gray
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var numOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of guests"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let customStepper: RoundStepper = {
        let blueOcean = UIColor(red: 51, green: 65, blue: 149)
        let stepper = RoundStepper(viewData: .init(color: blueOcean, minimum: 1, maximum: 10, stepValue: 1))
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
    }()

    var reserveButton: StyledButton = {
        let button = StyledButton(type: .system)
        button.setTitle("Reserve", for: .normal)
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
    }

    @objc func userProfileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.user = user
        navigationController?.pushViewController(userProfileViewController, animated: true)
        //        self.present(UINavigationController(rootViewController: userProfileViewController), animated: true, completion: nil)
    }

    @objc func reserveButtonTapped() {
        print("Reserve tapped")
    }

    @objc private func didStepperValueChanged() {
        print("latest value: \(customStepper.value)")
    }

    @objc func datePickerValueChanged() {
        let selectedDate = datePicker.date
    }
}

extension HomeViewController: HomeDisplayer {
    func showError(_ error: Error) {
        print("User data fetching error: \(error.localizedDescription)")

    }

    func showUser(_ user: UserModel) {
        // Update the UI on the main thread
        DispatchQueue.main.async { [weak self] in
            self?.user = user
            if let firstName = user.firstName {
                self?.helloUserNameLabel.text = "Welcome, \(firstName)"
            }
        }
    }
}
