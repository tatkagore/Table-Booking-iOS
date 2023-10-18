import UIKit

class ViewController: UIViewController {
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Table Reservation"
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.sizeToFit()
        return lbl
    }()

    // Define your table view
    let tableView = UITableView()

    // Define your custom toolbar
    let customToolbar = CustomToolbar() // CustomToolbar instance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color for your view controller's view
        self.view.backgroundColor = .gray

        // Set the title for your view controller
        self.title = "My Restaurant App"

        // Configure the titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")

        // Add the titleLabel to your view controller's view
        view.addSubview(titleLabel)

        // Set up constraints for the titleLabel
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true

        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self

        // Add the table view to your view controller's view
        view.addSubview(tableView)

        // Set up constraints for the tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Add the customToolbar to your view controller's view
        view.addSubview(customToolbar)

        // Set up constraints for the customToolbar
        let customToolbarHeight: CGFloat = 44.0 // Adjust the height as needed

        customToolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customToolbar)

        let toolbarConstraints = [
            customToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), // Use safeAreaLayoutGuide for safe area
            customToolbar.heightAnchor.constraint(equalToConstant: customToolbarHeight)
        ]

        NSLayoutConstraint.activate(toolbarConstraints)
    }

    @objc func simpleButtonTapped() {
        print("Simple Button tapped!")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        // Configure the cell with restaurant data
        let restaurant = restaurantData[indexPath.row]
        cell.textLabel?.text = restaurant.name

        return cell
    }
}
