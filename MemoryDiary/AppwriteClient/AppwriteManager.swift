//
//  Client.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Foundation
import Appwrite
import AppwriteModels

private let endpoint = "https://cloud.appwrite.io/v1"
private let projectId = "66d0f68a00340aa63e54"


@Observable
class AppwriteManager {
    
    static var shared = AppwriteManager() // Sigleton
    
    private let client: Client
    private let databases: Databases
    private let account: Account
    private let storage: Storage
    
    init() {
        self.client = Client()
            .setEndpoint(endpoint)
            .setProject(projectId)
        
        self.databases = Databases(client)
        self.account = Account(client)
        self.storage = Storage(client)
    }
    
    // MARK: - Database Methods
    
//    func createDocument(collectionId: String, documentId: String, data: [String: Any]) async throws {
//        do {
//            let document = try await databases.createDocument(
//                databaseId: "YOUR_DATABASE_ID",
//                collectionId: collectionId,
//                documentId: documentId,
//                data: data
//            )
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
//    func getDocument(collectionId: String, documentId: String) async throws {
//        do {
//            let document = try await databases.getDocument(
//                databaseId: "YOUR_DATABASE_ID",
//                collectionId: collectionId,
//                documentId: documentId
//            )
//            print(document)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    
    
    /// Creates a new account
    /// - Parameters:
    ///   - username: user's name
    ///   - email: user's email
    ///   - password: password
    /// - Returns: User
    func createAccount(username: String, email: String, password: String) async throws -> User? {
        do {
            let user = try await account.create(
                userId: ID.unique(),
                email: email,
                password: password,
                name: username
            )
            let decodedUser: User = .init(id: user.id, name: user.name, email: user.email, password: user.password ?? "")
            
            return decodedUser
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func createSession(email: String, password: String) async throws {
        do {
            let session = try await account.createEmailPasswordSession(email: email, password: password)
            print(session)
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func login(email: String, password: String) async throws -> Session {
//        return try await account.createEmailSession(
//            email: email,
//            password: password
//        )
//    }
    
    // MARK: - Storage Methods
    
//    func uploadFile(bucketId: String, fileId: String, file: File) async throws -> File {
//        return try await storage.createFile(
//            bucketId: bucketId,
//            fileId: fileId,
//            file: file
//        )
//    }
    
//    func getFile(bucketId: String, fileId: String) async throws -> File {
//        return try await storage.getFile(
//            bucketId: bucketId,
//            fileId: fileId
//        )
//    }
}
