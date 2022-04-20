//
//  UserModel.swift
//  DarkMod
//
//  Created by Test on 15/04/22.
//

import Foundation

struct User: Codable {
    
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
