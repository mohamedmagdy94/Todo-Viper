//
//  UserTodoListInteractor.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/9/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import Moya

class UserTodoListIteractor: InteractorToPresenterUserTodoListProtocol{
    
    var networkRouter: MoyaProvider<UserTodoNetworkRouter>
    var presenter: PresenterToInteractorUserTodoListProtocol?
    var response: UserListResponse?
    var userId: String
    
    init(presenter: PresenterToInteractorUserTodoListProtocol?,userId: String) {
        self.networkRouter =  MoyaProvider<UserTodoNetworkRouter>(plugins: [NetworkLoggerPlugin()])
        self.presenter = presenter
        self.userId = userId
    }
    
    func fetchTodoList() {
        let requestBody = UserTodoListRequest(userId: self.userId)
        networkRouter
            .request(.UserTodoList(request: requestBody)) {[weak self] (result) in
                guard let weakSelf = self else{ return }
                switch result{
                case .success(let moyaResponse):
                    let data = moyaResponse.data
                    let codableTransformer = CodableTransformer()
                    guard let responseModel = codableTransformer.decodeObject(from: data, to: UserTodoListResponse.self) else{
                        weakSelf.presenter?.onTodoListFetchFailed(with: UserTodoListError.ServerError)
                        return
                    }
                    weakSelf.presenter?.onTodoListFetchSucceess(with: responseModel)
                case .failure:
                    weakSelf.presenter?.onTodoListFetchFailed(with: UserTodoListError.ServerError)
                    break
                    
                }
        }
    }
    
    
}
