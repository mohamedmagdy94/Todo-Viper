//
//  UserTodoListNavigationRouter.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/9/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import UIKit

class UserTodoListNavigationRouter: RouterUserTodoListProtocol{
    static func createModule(in viewController: UIViewController,with userId: String){
        let destinationViewController = UIViewController.create(storyboardName: "UserTodoList", viewControllerID: "UserTodoListViewController") as! UserTodoListViewController
        let interactor = UserTodoListIteractor(presenter: nil, userId: userId)
        let router = UserTodoListNavigationRouter(viewController: destinationViewController)
        let presenter = UserTodoListPresenter(view: destinationViewController, interactor: interactor, router: router)
        interactor.presenter = presenter
        destinationViewController.presenter = presenter
        viewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
}
