//
//  MemoriesViewModel.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 30/10/24.
//

import Foundation
import Observation

enum FetchFlow {
    case fetching
    case fetched
    case error
}

enum FetchError: Error {
    case invalidField
}

@Observable
final class MemoriesViewModel {
    var memories: [Memory]
    var fetchFlow: FetchFlow
    
    private var databaseId = ProcessInfo.processInfo.environment["DATABASE_ID"] ?? ""
    private var collectionId = ProcessInfo.processInfo.environment["MEMORIES_COLLECTION"] ?? ""
    
    init() {
        self.memories = []
        self.fetchFlow = .fetching
        Task {
            try await getDocuments()
        }
    }
    
    @MainActor
    func getDocuments() async throws {
        do {
            let documents = try await AppwriteClient.shared.databases.listDocuments(
                databaseId: databaseId,
                collectionId: collectionId
            )
            self.memories = documents.documents.compactMap { doc in
                let data = doc.data
                
                let shape = data["backgroundShape"]?.value as? String ?? ""
                let timestamp = data["timestamp"]?.value as? String ?? nil
//                print(timestamp ?? "No date provided")
                let isoFormatter = ISO8601DateFormatter()
                isoFormatter.formatOptions = [
                    .withInternetDateTime,
                    .withFractionalSeconds
                ]
                
                var timestampDate: Date?
                if let timestamp = timestamp {
//                    print(timestamp)
                    timestampDate = isoFormatter.date(from: timestamp)
//                    print(timestampDate)
                }
//                print(type(of: timestamp))
//                print(type(of: timestampDate))
                
                let latitude = data["latitude"]?.value as? Double ?? nil
                let longitude = data["longitude"]?.value as? Double ?? nil
                var location: MemoryLocation?
                if let latitude = latitude, let longitude = longitude {
                    location?.latitude = latitude
                    location?.longitude = longitude
                }
                let meme = Memory(
                    id: data["$id"]?.value as? String ?? "",  // Use direct $id property from document
                    headerBackground: data["headerBackground"]?.value as? String,
                    backgroundShape: BackgroundShape(rawValue: shape) ?? .roundedRectangle,
                    title: data["title"]?.value as? String ?? "",
                    content: data["content"]?.value as? String ?? "",
                    timestampt: timestampDate,
                    location: location,
                    tags: data["tags"]?.value as? [String] ?? []
                )
                print(meme.timestampt)
//                print(type(of: meme.timestampt))
                return meme
            }

        } catch {
            print(error.localizedDescription)
        }
    }
}
