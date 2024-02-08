//
//  AlertMessage.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 07/02/2024.
//

import Foundation
import UIKit

class MyAlert {

    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }

    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()

    private var myTartgerView: UIView?

    private let backgroungView: UIView = {
        let backgroungView = UIView()
        backgroungView.backgroundColor = .black
        backgroungView.alpha = .zero
        return backgroungView
    }()

    var dismissCompletion: (() -> Void)?

    func showAlert(with title: String, message: String, on ViewController: UIViewController) {
        guard let targetView = ViewController.view else {
            return
        }
        myTartgerView = targetView
        backgroungView.frame = targetView.bounds
        targetView.addSubview(backgroungView)

        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 210)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.myBlue
        alertView.addSubview(titleLabel)

        let messageLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.size.width, height: 80))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        alertView.addSubview(messageLabel)

        let button = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height - 50, width: alertView.frame.size.width, height: 50))

        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)

        UIView.animate(withDuration: 0.25, animations: {
            self.backgroungView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }

    @objc func dismissAlert() {
        guard let targetView = myTartgerView else {
            return
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroungView.alpha = 0
                }, completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroungView.removeFromSuperview()
                        self.dismissCompletion?()
                    }
                })
            }
        })
    }
}
