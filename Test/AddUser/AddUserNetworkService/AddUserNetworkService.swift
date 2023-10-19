//
//  AddUserNetworkService.swift
//  Test
//
//  Created by Деним Мержан on 18.10.23.
//

import Foundation


class AddUserNetworkService {
    
    func addUserToServer(user: User, completion: @escaping(Result<PostUserQuery, NetworkError>) -> Void) {
        guard let url = Link.singleUser.url else {return}
        let userQuery = PostUserQuery(firstName: user.firstName, lastName: user.lastName)
        let jsonData = try? JSONEncoder().encode(userQuery)
        
        NetworkService.shared.postUser(jsonData, with: url) { result in
            switch result {
            case .success(let data):
                if let postUsersQuery = DecodeJson.decode(data: data, type: PostUserQuery.self, keyDecoding: nil) {
                    completion(.success(postUsersQuery))
                } else {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension AddUserNetworkService {
    enum Link {
        case singleUser
        
        var url: URL? {
            switch self {
            case .singleUser:
                return URL(string: "https://reqres.in/api/users/")
            }
        }
    }
}
