//
//  File.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 08/02/2024.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    static let identifier = "ReservationCell"

    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let numberOfGuestsLabel = UILabel()

    private let calendarIconImageView = UIImageView(image: UIImage(systemName: "calendar"))
    private let clockIconImageView = UIImageView(image: UIImage(systemName: "clock"))
    private let guestsIconImageView = UIImageView(image: UIImage(systemName: "person.3"))
    private let containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCellView()
    }

    private func setupCellView() {
        calendarIconImageView.tintColor = .black
        clockIconImageView.tintColor = .black
        guestsIconImageView.tintColor = .black

        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.gray.cgColor

        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])


        let dateStack = createStackView(with: calendarIconImageView, and: dateLabel)
        let timeStack = createStackView(with: clockIconImageView, and: timeLabel)
        let guestsStack = createStackView(with: guestsIconImageView, and: numberOfGuestsLabel)

        let horizontalStackView = UIStackView(arrangedSubviews: [dateStack, timeStack, guestsStack])
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 8

        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    private func createStackView(with imageView: UIImageView, and label: UILabel) -> UIStackView {
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }

    func configure(with reservation: ReservationModel) {
        let dateString = reservation.date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = dateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "d MMMM"
            let dayMonthString = dateFormatter.string(from: date)

            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: date)

            dateLabel.text = "\(dayMonthString)"
            timeLabel.text = "\(timeString)"
        } else {
            print("Invalid date format")
        }
        numberOfGuestsLabel.text = "\(reservation.numberOfGuests) guests"
    }
}
