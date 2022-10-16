//
//  User.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import Foundation

struct User {
    let name: String
    let address: String
    let contactNumber: String
    let postalCode: String
    let city: String
    let email: String
    let password: String
    let gender: String
    let dob: Date
    
    static var userList = [String: User]()
    
    static func addUser(newUser: User) -> Bool {
        if self.userList[newUser.email] == nil {
            self.userList[newUser.email] = newUser
            return true
        }
        
        return false
    }
    
    static func searchUser(email: String) -> User? {
        if self.userList[email] != nil{
            return self.userList[email]
        }
        
        return nil
    }
    
    static func deleteUser(email: String) -> Bool{
        if self.userList[email] != nil{
            self.userList[email] = nil
            return true
        }
        
        return false
    }
}
