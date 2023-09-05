//
//  User.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 05/09/23.
//

import Foundation
import CloudKit

class User {
    static private var user: User?
    
    let id: CKRecord.ID
    
    private init(id: CKRecord.ID) {
        self.id = id
    }
    
    
    static func instance() async -> User {
        if user == nil {
            do {
                let userId = try await CKContainer.default().userRecordID()
                user = User(id: userId)
            } catch {
                print("ERRO => user not fetched | using mock user")
                user = User(id: CKRecord.ID(recordName: "mockedUser"))
            }
        }
        
        return user!
    }
    
    static func start() {
        Task {
            let user = await Self.instance()
            print("user id fetched: \(user.id.recordName)")
        }
    }
}
