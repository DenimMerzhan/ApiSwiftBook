//
//  UserListNetworkError.swift
//  Test
//
//  Created by Деним Мержан on 13.10.23.
//

import Foundation

final class UserListNetworService {
    
    func fetchUsers(completion: @escaping(Result<[User], NetworkError>) -> Void) {
        guard let url = Link.allUsers.url else {return}
        NetworkService.shared.fetchUsers(with: url) { result in
            
            switch result {
            case .failure(let error):
                switch error {
                case .noData:
                    completion(.failure(.noData))
                default: break
                }
                
            case .success(let data):
                if let usersQuery = UserModel().decodeJson(data: data, type: UsersQuery.self, keyDecoding: .convertFromSnakeCase) {
                    
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
}


// MARK: - Link

extension UserListNetworService {
    enum Link {
        case allUsers
        case withNoData
        case withDecodingError
        case withNoUsers
        
        var url: URL? {
            switch self {
            case .allUsers:
                return URL(string: "https://reqres.in/api/users/?delay=2")
            case .withNoData:
                return URL(string: "https://reqres.in/api/users")
            case .withDecodingError:
                return URL(string: "https://reqres.in/api/users/3?delay=2")
            case .withNoUsers:
                return URL(string: "https://reqres.in/api/users/?delay=2&page=3")
            }
        }
    }
}
