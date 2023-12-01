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
    var user: UserModel?
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
        label.text = "Chose time when do you plan to visit?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
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
        label.text = "Write any note to let us know more details:"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type here..."
        textField.textColor = .gray // Change text color
        textField.font = UIFont.systemFont(ofSize: 16) // Change font and size
        textField.backgroundColor = .white // Change background color
        textField.borderStyle = .roundedRect // Change border style
        textField.layer.cornerRadius = 8 // Round corners
        textField.layer.borderWidth = 1.0 // Add border width
        textField.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
       }()
    var numOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "How many people?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let customStepper: RoundStepper = {
        let blueOcean = UIColor(red: 51, green: 65, blue: 149)
        let stepper = RoundStepper(viewData: .init(color: blueOcean, minimum: 0, maximum: 100, stepValue: 10))
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(helloUserNameLabel)
        view.addSubview(letsBookTableLabel)
        view.addSubview(userProfileButton)
        view.addSubview(whenPlanVisitLabel)
        presenter.bind(displayer: self)
        setUpConstraints()
        presenter.onViewDidLoad()
    }

    @objc func userProfileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.user = user
        navigationController?.pushViewController(userProfileViewController, animated: true)
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
