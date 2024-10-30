//
//  MemoriesList.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 30/10/24.
//

import SwiftUI

struct MemoriesList: View {
    @State var memoriesVM = MemoriesViewModel()
    var body: some View {
        VStack {
            ForEach(memoriesVM.memories) { memory in
                VStack {
                    Text(memory.id)
                    Text(memory.backgroundShape.rawValue)
                    Text(memory.title)
                    Text(memory.content)
                    if let timestamp = memory.timestampt {
                        Text(timestamp, style: .date)
                    }

                    Text(memory.tags.description)
                    Divider()
                }
            }
        }
    }
}

#Preview {
    MemoriesList()
}
