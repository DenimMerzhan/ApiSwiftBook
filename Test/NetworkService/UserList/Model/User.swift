//
//  User.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation

struct User: Decodable {
    
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: URL
}

struct UsersQuery: Decodable {
    let data: [User]
}
