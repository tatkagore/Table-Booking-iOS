//
//  MenuPresenter.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 14/05/2024.
//

import Foundation

// Protocol to define methods for the presenter
protocol MenuPresenter {
    func bind(displayer: MenuDisplayer)
    func fetchMenu()
}

class MenuPresenterImpl: MenuPresenter {

    weak var displayer: MenuDisplayer?

    func bind(displayer: MenuDisplayer) {
        self.displayer = displayer
    }

    func fetchMenu() {
        let menuCategories = [
            MenuCategory(title: "Entrée", items: [
                MenuItem(name: "French Onion Soup", description: "A rich beef broth with caramelized onions and cheese crouton.", price: 6.99),
                MenuItem(name: "Bruschetta", description: "Grilled bread with tomato, basil, and mozzarella.", price: 5.99)
            ], imageName: "Entrée"),

            MenuCategory(title: "Plate", items: [
                MenuItem(name: "Grilled Salmon", description: "Served with a lemon butter sauce and seasonal vegetables.", price: 15.99),
                MenuItem(name: "Filet Mignon", description: "Tender beef filet served with garlic mashed potatoes.", price: 22.99)
            ], imageName: "Plate"),

            MenuCategory(title: "Dessert", items: [
                MenuItem(name: "Cheesecake", description: "Classic cheesecake with a graham cracker crust.", price: 6.99),
                MenuItem(name: "Chocolate Lava Cake", description: "Warm chocolate cake with a molten center.", price: 7.99)
            ], imageName: "Dessert"),

            MenuCategory(title: "Appetizer", items: [
                MenuItem(name: "Stuffed Mushrooms", description: "Mushrooms stuffed with cheese and herbs.", price: 6.99),
                MenuItem(name: "Shrimp Cocktail", description: "Chilled shrimp served with cocktail sauce.", price: 8.99)
            ], imageName: "Appetizer"),

            MenuCategory(title: "Drinks", items: [
                MenuItem(name: "Margarita", description: "Classic margarita with fresh lime juice.", price: 7.99),
                MenuItem(name: "Mojito", description: "Refreshing mojito with mint and lime.", price: 6.99)
            ], imageName: "Drinks"),

            MenuCategory(title: "Salad", items: [
                MenuItem(name: "Greek Salad", description: "Traditional Greek salad is simple and vibrant. Fresh tomatoes, cucumber, red onion, olive and feta, tossed in an herby Greek salad dressing", price: 3.99)
            ], imageName: "Salad")
        ]

        displayer?.showMenu(with: menuCategories)
    }
}
