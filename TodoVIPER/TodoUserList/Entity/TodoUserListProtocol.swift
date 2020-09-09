//
//  TodoUserListProtocol.swift
//  VIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

protocol PresenterToViewTodoUserListProtocol{
    var usersCellViewModels: [TodoUserTableCellViewModel]{ get }
    func onScreenOpened()
    func onUserSelected(with index: Int)
}

protocol ViewToPresenterTodoUserListProtocol {
    func showLoading()
    func showUsersList()
    func showError(with message: String)
    func dismissLoading()
}

protocol InteractorToPresentTodoUserListProtocol {
    func fetchUserList()
    func fetchUser(with index: Int)
}

protocol PresenterToInteractorTodoUserListProtocol{
    func onUserListFetchSucceess(with response: UserListResponse)
    func onUserListFetchFailed(with error: TodoUserListError)
    func onUserFetched(with user: User)
}

typealias TodoUserListPresenterProtocol = PresenterToViewTodoUserListProtocol & PresenterToInteractorTodoUserListProtocol


protocol RouterTodoUserListProtocol {
    func showUserDetails(from user: User)
}

