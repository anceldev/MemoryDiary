//
//  DMemory.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Appwrite
import CoreLocation
import Foundation

enum BackgroundShape: String, Codable {
    case circle
    case roundedRectangle
    case box
}

final class Memory: Codable, Identifiable {
    var id: String
    var headerBackground: String?
    var backgroundShape: BackgroundShape
    var title: String
    var content: String
    var timestampt: Date?
    var location: MemoryLocation?
    var tags: [String]
    
    
    init(id: String = Appwrite.ID.unique() , headerBackground: String? = nil, backgroundShape: BackgroundShape = .roundedRectangle, title: String = "", content: String = "", timestampt: Date? = nil, location: MemoryLocation?, tags: [String] = []) {
        self.id = id
        self.headerBackground = headerBackground
        self.backgroundShape = backgroundShape
        self.title = title
        self.content = content
        self.timestampt = timestampt
        self.location = location
        self.tags = tags
    }
}

extension Memory {
    static let memoryPreview: Memory = .init(
        id: Appwrite.ID.unique(),
        headerBackground: nil,
        title: "Sunday celebration",
        content: "Today our Pastor preached about the honor and how can we become blessed through that. She talked about Jesus, about following him with spirit and not just with knowledge. This is the first of twelve preaches about honor",
        timestampt: nil,
        location: .init(latitude: 41.631149, longitude: -4.747001),
        tags: [
        "honor",
        "celebration"
        ])
    
    static let memoryPreviews: [Memory] = [Memory.memoryPreview]
}
class MemoryLocation: Codable {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

//41.631149, -4.747001
extension Memory {
    static let preview: Memory = .init(
        headerBackground: nil,
        title: "Thinking",
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance.",
        timestampt: .now,
        location: nil,
        tags: ["new", "inspiration"]
    )
}
