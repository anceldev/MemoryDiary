//
//  MemorieViewModel.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 30/10/24.
//

import Foundation
import Observation
import Appwrite

enum CreateFlow {
    case creating
    case uploading
    case uploaded
}

@Observable
final class MemorieViewModel {
    var memory: Memory?
    var createFlow: CreateFlow
    
    private var databaseId = ProcessInfo.processInfo.environment["DATABASE_ID"] ?? ""
    private var collectionId = ProcessInfo.processInfo.environment["MEMORIES_COLLECTION"] ?? ""
    
    init() {
        self.memory = nil
        self.createFlow = .creating
    }
    
    @MainActor
    func createDocument(headerBackground: String?, backgroundShape: BackgroundShape, title: String, content: String, timestamp: Date?, location: MemoryLocation?, tags: [String]) async throws {
        self.createFlow = .creating
        do {
            let isoFormatter = ISO8601DateFormatter()
            self.createFlow = .uploading
            
            let _ = try await AppwriteClient.shared.databases.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: [
                    "title": title,
                    "content": content,
                    "timestamp": timestamp == nil ? nil : isoFormatter.string(from: timestamp!),
                    "tags": tags
                ])
            self.createFlow = .uploaded
        } catch {
            print(error.localizedDescription)
            self.createFlow = .creating
        }
    }
    
    
}
