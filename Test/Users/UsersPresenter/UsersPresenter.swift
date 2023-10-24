//
//  UsersPresenter.swift
//  Test
//
//  Created by Деним Мержан on 24.10.23.
//

import Foundation

protocol UsersPresenterDelegate: AnyObject {
    
}

class UsersPresenter {
    
    weak var delegate: UsersPresenterDelegate?
    
    
    func fetchUsers(completion: @escaping(Result<[User], NetworkError>) -> Void) {
        guard let url = Link.allUsers.url else {return}
        NetworkService.shared.getData(with: url) { result in
            
            switch result {
            case .failure(let error):
                switch error {
                case .noData:
                    completion(.failure(.noData))
                default: break
                }
                
            case .success(let data):
                if let usersQuery = DecodeJson.decode(data: data, type: UsersQuery.self, keyDecoding: .convertFromSnakeCase) {
                    
                    if usersQuery.data.isEmpty {
                        completion(.failure(.noUsers))
                    } else {
                        completion(.success(usersQuery.data))
                    }
                    
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
    func deleteUser(id: Int,completion: @escaping (Bool) -> ()){
        guard let stringUrl = Link.singleUser.url?.absoluteString, let userUrl = URL(string: stringUrl + "\(id)") else {return}
        
        NetworkService.shared.deleteData(with: userUrl) { success in
            completion(success)
        }
    }
    
}


// MARK: - Link

extension UsersPresenter {
    enum Link {
        case allUsers
        case singleUser
        case withNoData
        case withDecodingError
        case withNoUsers
        
        var url: URL? {
            switch self {
            case .allUsers:
                return URL(string: "https://reqres.in/api/users/?delay=2")
            case .singleUser:
                return URL(string: "https://reqres.in/api/users/")
            case .withNoData:
                return URL(string: "https://reqres.int/api/users")
            case .withDecodingError:
                return URL(string: "https://reqres.in/api/users/3?delay=2")
            case .withNoUsers:
                return URL(string: "https://reqres.in/api/users/?delay=2&page=3")
            }
        }
    }
}
