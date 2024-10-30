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

@Observable
class AppwriteClient {
    
    let client: Client
    let databases: Databases
    let account: Account
    let storage: Storage
    
    private let endpoint = "https://cloud.appwrite.io/v1"
    private let projectId = ProcessInfo.processInfo.environment["PROJECT_ID"]
    
    init() {
        self.client = Client()
            .setEndpoint(endpoint)
            .setProject(projectId ?? "")
        self.databases = Databases(client)
        self.account = Account(client)
        self.storage = Storage(client)
    }
}
extension AppwriteClient {
    static var shared = AppwriteClient()
}
