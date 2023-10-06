//
//  NetworkService.swift
//
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation

enum NetworkError: Error {
    case invaidURL, decodingError, noData
}


class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchAvatar(from url: URL, completion: @escaping (Data) -> Void) {
        
        DispatchQueue.global(qos: .default).async {
            
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                completion(imageData)
            }

        }
    }
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = Link.allUsers.url else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("response status code - \(response.statusCode)")
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error decsription")
                completion(.failure(.noData))
                return
            }
            
            if let usersQuery = UserModel().decodeJson(data: data, type: UsersQuery.self, keyDecoding: .convertFromSnakeCase) {
                DispatchQueue.main.async {
                    completion(.success(usersQuery.data))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}


// MARK: - Link

extension NetworkService {
    enum Link {
        case allUsers
        
        var url: URL? {
            switch self {
            case .allUsers:
                return URL(string: "https://reqres.in/api/users")
            }
        }
    }
}
