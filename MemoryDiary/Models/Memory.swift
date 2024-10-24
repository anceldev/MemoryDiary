//
//  DMemory.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Appwrite
import CoreLocation
import Foundation

final class Memory: Codable {
    let id: String
    let heading: String
    let content: String
    let timestampt: Date
    let location: MemoryLocation?
    let tags: [String]
    
    
    init(id: String = ID.unique() , heading: String = "", content: String = "", timestampt: Date, location: MemoryLocation?, tags: [String] = []) {
        self.id = id
        self.heading = heading
        self.content = content
        self.timestampt = timestampt
        self.location = location
        self.tags = tags
    }
}

extension Memory {
    static let memoryPreview: Memory = .init(
        id: ID.unique(),
        heading: "Sunday celebration",
        content: "Today our Pastor preached about the honor and how can we become blessed through that. She talked about Jesus, about following him with spirit and not just with knowledge. This is the first of twelve preaches about honor",
        timestampt: .now,
        location: .init(latitude: 41.631149, longitude: -4.747001),
        tags: [
        "honor",
        "celebration"
        ])
    
    static let memoryPreviews: [Memory] = [Memory.memoryPreview]
    
    class MemoryLocation: Codable {
        let latitude: Double
        let longitude: Double
        
        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}

//41.631149, -4.747001
