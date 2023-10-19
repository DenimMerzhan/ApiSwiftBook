//
//  NetworkService.swift
//
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation

enum NetworkError: Error {
    
    case noData
    case decodingError
    case noUsers
    
    var description: String {
        switch self {
        case .noData:
            return "Отсутствуют данные"
        case .decodingError:
            return "Ошибка декодирования"
        case .noUsers:
            return "Отуствуют пользователи"
        }
    }
}


class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func getData(with url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            guard let data = data else {
                print(error?.localizedDescription ?? "No error decsription")
                sendFailure(with: .noData)
                return
            }
            
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) { /// 200-299 значит ответ был успешный
                print("response status code - \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
            
            func sendFailure(with error: NetworkError) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func postUser(_ data: Data?, with url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {return}
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    
}



