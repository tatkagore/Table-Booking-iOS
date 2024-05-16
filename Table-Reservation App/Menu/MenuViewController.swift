//
//  MenuViewController.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 14/05/2024.
//

import UIKit

protocol MenuDisplayer: AnyObject {
    func showMenu(with categories: [MenuCategory])
}

class MenuViewController: UIViewController {
    var presenter: MenuPresenter = MenuPresenterImpl()
    var categories: [MenuCategory] = []

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Menu"

        presenter.bind(displayer: self)
        presenter.fetchMenu()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCategoryCell.self, forCellWithReuseIdentifier: "MenuCategoryCell")

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MenuViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCategoryCell", for: indexPath) as! MenuCategoryCell
        let category = categories[indexPath.item]
        cell.configure(with: category, imageName: category.imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        let detailVC = MenuCategoryDetailViewController()
        detailVC.category = category
        navigationController?.pushViewController(detailVC, animated: true)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let numberOfColumns: CGFloat = 2
          let width = (collectionView.frame.width - (numberOfColumns + 1) * 10) / numberOfColumns
          return CGSize(width: width, height: 200)
      }
}

extension MenuViewController: MenuDisplayer {


    func showMenu(with categories: [MenuCategory]) {
        self.categories = categories
        collectionView.reloadData()
    }
}
