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
                MenuItem(name: "French Onion Soup", description: "A rich beef broth with caramelized onions", price: 6.99, imageName: "French Onion Soup"),
                MenuItem(name: "Bruschetta", description: "Grilled bread with tomato & mozzarella.", price: 5.99, imageName: "Bruschetta"),
                MenuItem(name: "Stuffed Zucchini", description: "Zucchini stuffed with cheese and herbs.", price: 7.49, imageName: "Stuffed Zucchini"),
                MenuItem(name: "Mini Quiches", description: "Small quiches with spinach and cheese.", price: 6.49, imageName: "Mini Quiches")
            ], imageName: "Entrée"),

            MenuCategory(title: "Plate", items: [
                MenuItem(name: "Grilled Salmon", description: "Served with a lemon butter sauce", price: 15.99, imageName: "Grilled Salmon"),
                MenuItem(name: "Filet Mignon", description: "Tender beef filet with garlic mashed potatoes.", price: 22.99, imageName: "Filet Mignon"),
                MenuItem(name: "Chicken Alfredo", description: "Pasta with creamy Alfredo sauce and chicken.", price: 14.99, imageName: "Chicken Alfredo"),
                MenuItem(name: "Vegetable Stir Fry", description: "Mixed vegetables stir-fried with soy sauce.", price: 12.99, imageName: "Vegetable Stir Fry")
            ], imageName: "Plate"),

            MenuCategory(title: "Dessert", items: [
                MenuItem(name: "Cheesecake", description: "Classic cheesecake with a graham cracker crust.", price: 6.99, imageName: "Cheesecake"),
                MenuItem(name: "Chocolate Lava Cake", description: "Warm chocolate cake with a molten center.", price: 7.99, imageName: "Chocolate Lava Cake"),
                MenuItem(name: "Tiramisu", description: "Italian dessert with coffee and mascarpone.", price: 6.49, imageName: "Tiramisu"),
                MenuItem(name: "Apple Pie", description: "Classic apple pie with a flaky crust.", price: 5.99, imageName: "Apple Pie")
            ], imageName: "Dessert"),

            MenuCategory(title: "Appetizer", items: [
                MenuItem(name: "Stuffed Mushrooms", description: "Mushrooms stuffed with cheese and herbs.", price: 6.99, imageName: "Stuffed Mushrooms"),
                MenuItem(name: "Shrimp Cocktail", description: "Chilled shrimp served with cocktail sauce.", price: 8.99, imageName: "Shrimp Cocktail"),
                MenuItem(name: "Spring Rolls", description: "Crispy spring rolls with a sweet chili dipping sauce.", price: 5.99, imageName: "Spring Rolls"),
                MenuItem(name: "Caprese Skewers", description: "Tomato, mozzarella, and basil skewers.", price: 5.49, imageName: "Caprese Skewers")
            ], imageName: "Appetizer"),

            MenuCategory(title: "Drinks", items: [
                MenuItem(name: "Margarita", description: "Classic margarita with fresh lime juice.", price: 7.99, imageName: "margarita"),
                MenuItem(name: "Mojito", description: "Refreshing mojito with mint and lime.", price: 6.99, imageName: "Mojito"),
                MenuItem(name: "Old Fashioned", description: "Classic cocktail with whiskey and bitters.", price: 8.49, imageName: "Old Fashioned"),
                MenuItem(name: "Pina Colada", description: "Creamy cocktail with pineapple and coconut.", price: 7.49, imageName: "Pina Colada")
            ], imageName: "Drinks"),

            MenuCategory(title: "Salad", items: [
                MenuItem(name: "Greek Salad", description: "Traditional Greek salad with feta cheese.", price: 3.99, imageName: "Greek Salad"),
                MenuItem(name: "Caesar Salad", description: "Classic Caesar salad with romaine and croutons.", price: 4.99, imageName: "Caesar Salad"),
                MenuItem(name: "Caprese Salad", description: "Fresh tomatoes, mozzarella, and basil.", price: 4.49, imageName: "Caprese Salad"),
                MenuItem(name: "Cobb Salad", description: "Mixed greens with chicken, bacon.", price: 5.49, imageName: "Cobb Salad")
            ], imageName: "Salad")
        ]

        displayer?.showMenu(with: menuCategories)
    }
}
