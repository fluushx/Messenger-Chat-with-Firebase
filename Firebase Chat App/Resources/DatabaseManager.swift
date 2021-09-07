//
//  DatabaseManager.swift
//  Firebase Chat App
//
//  Created by Felipe Ignacio Zapata Riffo on 07-09-21.
//

import Foundation
import FirebaseDatabase
final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
}

struct ChatAppUser {
    let firstName:String
    let lastName: String
    let mail: String
     var safeMail:String{
        var safeMail = mail.replacingOccurrences(of: ".", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "@", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "#", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "$", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "' '", with: "-")
        return safeMail
    }
}

//MARK:- Account Management
extension DatabaseManager {
    public func userExists (with mail:String,completion: @escaping((Bool)->Void)){
        
        var safeMail = mail.replacingOccurrences(of: ".", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "@", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "#", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "$", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "' '", with: "-")
        database.child(safeMail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    ///insert new user database
    public func insertUser(with user:ChatAppUser){
        database.child(user.safeMail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
            
        ])
    }
}
