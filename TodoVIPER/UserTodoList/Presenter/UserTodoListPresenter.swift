//
//  UserTodoListPresenter.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/9/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

class UserTodoListPresenter: UserTodoListPresenterProtocol{
    
    var todoCellViewModels: [UserTodoCellViewModel]
    var interactor: InteractorToPresenterUserTodoListProtocol?
    var router: UserTodoListNavigationRouter?
    var view: ViewToPresenterUserTodoListProtocol?
    
    init(view: ViewToPresenterUserTodoListProtocol?,interactor: InteractorToPresenterUserTodoListProtocol?,router: UserTodoListNavigationRouter?) {
        self.todoCellViewModels = []
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func onScreenOpened() {
        self.view?.showLoading()
        self.interactor?.fetchTodoList()
    }
    
    func onTodoListFetchSucceess(with response: UserTodoListResponse) {
        self.todoCellViewModels = response.map{ UserTodoCellViewModel(title: $0.title, body: $0.body) }
        self.view?.showTodoList()
        self.view?.dismissLoading()
    }
    
    func onTodoListFetchFailed(with error: UserTodoListError) {
        self.view?.showError(with: error.localizedDescription)
    }
    
    
}
