//
//  ViewController.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavController(
                viewController: CircleViewController.make(with: CircleViewModel()),
                title: "技術書店",
                imageName: "circle"
            ),
            createController(
                viewController: SearchCircleViewController.make(with: SearchCircleViewModel()),
                title: "検索",
                imageName: "circle"
            ),
            createController(
                viewController: ProductViewController.make(with: ProductViewModel(repository: ProductRepositoryImpl())),
                title: "検索",
                imageName: "circle"
            ),
            createNavController(
                viewController: HomeViewController.make(with: HomeViewModel(language: "swift")),
                title: "GitHub",
                imageName: "Github"
            )
        ]
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    private func createController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}

