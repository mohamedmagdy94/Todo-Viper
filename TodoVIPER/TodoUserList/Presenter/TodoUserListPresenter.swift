//
//  TodoUserListPresenter.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

class TodoUserListPresenter:TodoUserListPresenterProtocol{
    
    
    var view: ViewToPresenterTodoUserListProtocol?
    var interactor: InteractorToPresentTodoUserListProtocol?
    var router: RouterTodoUserListProtocol?
    var usersCellViewModels: [TodoUserTableCellViewModel]
    
    init(view: ViewToPresenterTodoUserListProtocol?,interactor: InteractorToPresentTodoUserListProtocol?,router: RouterTodoUserListProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.usersCellViewModels = []
    }
    
    func onScreenOpened() {
        self.view?.showLoading()
        self.interactor?.fetchUserList()
    }
    
    func onUserSelected(with index: Int) {
        self.interactor?.fetchUser(with: index)
    }
    
    func onUserListFetchSucceess(with response: UserListResponse) {
        self.view?.dismissLoading()
        self.usersCellViewModels = response.map{ TodoUserTableCellViewModel(name: $0.username) }
        self.view?.showUsersList()
    }
    
    func onUserListFetchFailed(with error: TodoUserListError) {
        self.view?.showError(with: error.localizedDescription)
    }
    
    func onUserFetched(with user: User) {
        router?.showUserDetails(from: user)
    }
    
    
}
