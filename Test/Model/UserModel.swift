//
//  UserModel.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation


struct UserModel {
    
    
    func decodeJson<T: Decodable>(data: Data, type: T.Type, keyDecoding: JSONDecoder.KeyDecodingStrategy?) -> T? {
        let jsonDecoder = JSONDecoder()
        
        if let keyDecoding = keyDecoding {
            jsonDecoder.keyDecodingStrategy = keyDecoding
        }
        
        do {
            let decodeData = try jsonDecoder.decode(type.self, from: data)
            return decodeData
        } catch {
            print("Ошибка декодирования - \(error)")
            return nil
        }
    }
}
