//
//  TodoUserListNavigationRouter.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import UIKit

class TodoUserListNavigationRouter: RouterTodoUserListProtocol{
    
    static func createModule(in window: UIWindow){
        let viewController = UIViewController.create(storyboardName: "TodoUserList", viewControllerID: "TodoUserListViewController") as! TodoUserListViewController
        let interactor = TodoUserListInteractor(presenter: nil)
        let presenter = TodoUserListPresenter(view: viewController, interactor: interactor, router: TodoUserListNavigationRouter())
        interactor.presenter = presenter
        viewController.presenter = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
        
    func showUserDetails(from user: User) {
        
    }
    
}
