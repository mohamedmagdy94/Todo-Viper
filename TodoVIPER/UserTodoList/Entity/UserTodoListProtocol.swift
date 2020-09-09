//
//  UserTodoListProtocol.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/9/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

protocol ViewToPresenterUserTodoListProtocol {
    func showLoading()
    func showTodoList()
    func showError(with message: String)
    func dismissLoading()
}

protocol PresenterToViewUserTodoListProtocol {
    var todoCellViewModels: [UserTodoCellViewModel]{ get }
    func onScreenOpened()
    
}

protocol PresenterToInteractorUserTodoListProtocol {
    func onTodoListFetchSucceess(with response: UserTodoListResponse)
    func onTodoListFetchFailed(with error: UserTodoListError)
}

typealias UserTodoListPresenterProtocol = PresenterToViewUserTodoListProtocol & PresenterToInteractorUserTodoListProtocol


protocol InteractorToPresenterUserTodoListProtocol {
    func fetchTodoList()
}

protocol RouterUserTodoListProtocol {
    
}
