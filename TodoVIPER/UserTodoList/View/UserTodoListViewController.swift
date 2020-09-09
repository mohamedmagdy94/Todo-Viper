//
//  UserTodoListViewController.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/2/20.
//  Copyright (c) 2020 Learning. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import KRProgressHUD

class UserTodoListViewController: UIViewController
{
    
    @IBOutlet weak var userTodoTableView: UITableView!
    
    var presenter: PresenterToViewUserTodoListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onScreenOpened()
    }
    
}

extension UserTodoListViewController: ViewToPresenterUserTodoListProtocol{
    
    func showLoading() {
        KRProgressHUD.show()
    }
    
    func showTodoList() {
        userTodoTableView.reloadData()
    }
    
    func showError(with message: String) {
        KRProgressHUD.showError(withMessage: message)
    }
    
    func dismissLoading() {
        KRProgressHUD.dismiss()
    }
    
    
}

extension UserTodoListViewController: UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.todoCellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = presenter?.todoCellViewModels[indexPath.row] else{ return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTodoTableViewCell.IDENTIFIER, for: indexPath) as! UserTodoTableViewCell
        cell.config(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}

