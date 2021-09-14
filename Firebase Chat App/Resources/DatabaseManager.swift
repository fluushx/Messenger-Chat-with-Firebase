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
    
    static func safeEmail(emailAddress:String)->String{
        var safeMail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "@", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "#", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "$", with: "-")
        safeMail = safeMail.replacingOccurrences(of: "' '", with: "-")
        return safeMail
    }
    
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
    var profilePictureFileName: String{
        //profile_picture.png
        return "\(safeMail)_profile_picture.png"
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
    public func insertUser(with user:ChatAppUser, completion: @escaping(Bool)->Void){
        database.child(user.safeMail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
            
        ],withCompletionBlock: { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                    if var usersColecction = snapshot.value as? [[String:String]] {
                    //append  to user dictionary
                        let newElement = [
                                "name":user.firstName + " " + user.lastName,
                                "email":user.safeMail
                            ]
                        
                        usersColecction.append(newElement)
                        self.database.child("users").setValue(usersColecction,withCompletionBlock: { error, _ in
                            guard error == nil else {
                                completion(false)
                                return
                            }
                            completion(true)
                        })
                }
                    else {
                        //create that  array
                        let newCollection : [[String:String]] = [
                            [
                                "name":user.firstName + " " + user.lastName,
                                "email":user.safeMail
                            ]
                        ]
                        self.database.child("users").setValue(newCollection,withCompletionBlock: { error, _ in
                            guard error == nil else {
                                completion(false)
                                return
                            }
                            completion(true)
                        })
                    }
            })
             
        })
    }
    public func getAllUsers (completion: @escaping (Result<[[String:String]],Error>)->Void){
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String:String]] else {
                completion(.failure(DataseError.failedToFetch))
                return
            }
            completion(.success(value))
        })
        
    }
}

public enum DataseError: Error{
    case failedToFetch
}

extension Notification.Name {
    static let didLogInNotification = Notification.Name("didLogInNotification")
}
