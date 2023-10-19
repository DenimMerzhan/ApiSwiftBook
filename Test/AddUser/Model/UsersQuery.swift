//
//  File.swift
//  Test
//
//  Created by Деним Мержан on 18.10.23.
//

import Foundation


struct PostUserQuery: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "name"
        case lastName = "job"
    }
}
