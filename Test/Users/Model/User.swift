//
//  User.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation

struct User: Decodable {
    
    var id: Int?
    var email: String?
    var firstName: String
    var lastName: String
    var avatar: URL?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(postUserQuery: PostUserQuery) {
        self.firstName = postUserQuery.firstName
        self.lastName = postUserQuery.lastName
    }
}

struct UsersQuery: Decodable {
    let data: [User]
}
