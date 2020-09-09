//
//  TodoUserListInteractor.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import Moya

class TodoUserListInteractor: InteractorToPresentTodoUserListProtocol{
    
    var networkRouter: MoyaProvider<TodoUserListNetworkRouter>
    var presenter: PresenterToInteractorTodoUserListProtocol?
    var response: UserListResponse?
    
    init(presenter: PresenterToInteractorTodoUserListProtocol?) {
        self.networkRouter =  MoyaProvider<TodoUserListNetworkRouter>(plugins: [NetworkLoggerPlugin()])
        self.presenter = presenter
    }
    
    func fetchUserList() {
        networkRouter
            .request(.TodoUserList) {[weak self] (result) in
                guard let weakSelf = self else{ return }
                switch result{
                case .success(let moyaResponse):
                    let data = moyaResponse.data
                    let codableTransformer = CodableTransformer()
                    guard let responseModel = codableTransformer.decodeObject(from: data, to: UserListResponse.self) else{
                        weakSelf.presenter?.onUserListFetchFailed(with: TodoUserListError.ServerError)
                        return
                    }
                    weakSelf.response = responseModel
                    weakSelf.presenter?.onUserListFetchSucceess(with: responseModel)
                case .failure:
                    weakSelf.presenter?.onUserListFetchFailed(with: TodoUserListError.ServerError)
                    break
                    
                }
        }
    }
    
    func fetchUser(with index: Int) {
        guard let response = response else{ return }
        let user = response[index]
        presenter?.onUserFetched(with: user)
    }
    
    
}
