//
//  NetworkService.swift
//  
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation


class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchAvatar(from url: URL, completion: @escaping (Data) -> Void) {
        
        DispatchQueue.global(qos: .default).async {
            
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                completion(imageData)
            }

        }
    }
    
    private init() {}
    
}
