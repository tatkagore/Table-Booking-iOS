//
//  ReservationViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 05/02/2024.
//

import Foundation
import UIKit

protocol ReservationDisplayer: AnyObject {
}
protocol ReservationPresenterDelegate: AnyObject {
}

class ReservationViewController: UIViewController{
    var reservation: ReservationModel?

    var choseDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Chose date and time"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.myBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpConstrains()
        // Custom title view
        let titleLabel = UILabel()
        titleLabel.text = "Please check your booking"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
    }

    @objc private func didStepperValueChanged() {
        print("latest value: \(customStepper.value)")
    }

    @objc func datePickerValueChanged() {
        let selectedDate = datePicker.date
    }

    @objc func reserveButtonTapped() {
        print("Reserved a table")
    }
}
extension ReservationViewController {
    // MARK: - Auto Layout
    func setUpConstrains() {

        let stackView = UIStackView(arrangedSubviews: [numOfPeopleLabel, customStepper])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(choseDateAndTimeLabel)
        view.addSubview(datePicker)
        view.addSubview(stackView)
        view.addSubview(noteLabel)
        view.addSubview(textField)
        view.addSubview(reserveButton)
        NSLayoutConstraint.activate([

            choseDateAndTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            choseDateAndTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            datePicker.topAnchor.constraint(equalTo: choseDateAndTimeLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            noteLabel.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 20),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            textField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalToConstant: 190),

            reserveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            reserveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),




        ])
    }
}
