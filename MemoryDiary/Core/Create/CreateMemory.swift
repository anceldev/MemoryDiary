//
//  CreateMemory.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 24/10/24.
//

import SwiftUI


struct CreateMemory: View {
    enum FocusedField: Hashable {
        case title, tag, text
    }
    @State private var title = ""
    @State private var tag = ""
    @State private var text = ""
    @State private var tags: [String] = []
    
    @FocusState private var focused: FocusedField?
    @State private var selectedButton: ToolButtons?
    var body: some View {
        ZStack {
            VStack {
                Text("Create Memory view")
                TextField("Title", text: $title)
                    .focused($focused, equals: .title)
                    .onSubmit {
                        focused = nil
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .bold))
                    .tint(.gray1)
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                            Text("#\(tag)")
                                .italic()
                                .foregroundStyle(.gray1)
                                .font(.system(size: 16, weight: .light))
                                
                        }
                    }
                    TextField("Add a tag", text: $tag)
                        .focused($focused, equals: .tag)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            tags.append(tag)
                            tag = ""
                        }
                        .tint(.gray1.opacity(0.7))
                        .foregroundStyle(.white)
                }
                if selectedButton == .text {
                    TextEditor(text: $text)
                        .focused($focused, equals: .text)
                        .scrollContentBackground(.hidden)
                        .background(.bg)
                        .tint(.gray1)
                        .foregroundStyle(.white)
                    
                } else {
                    Text(text)
                }
                Spacer()
            }
            .padding()
            VStack {
                Spacer()
                ToolsBar(selectedButton: $selectedButton, toolButtons: [
                    (ToolButtons.photo, { print("Adding photo...")}),
                    (ToolButtons.title, {
                        focused = .title
                    }),
                    (ToolButtons.text, { focused = .text }),
                    (ToolButtons.tag, { focused = .tag }),
                    (ToolButtons.mappin, { print("Adding location...")}),
                    (ToolButtons.date, { print("Adding date...")})
                ])
                .padding(.bottom, 10)
            }
        }
        .background(.bg)
    }
}
#Preview(body: {
    CreateMemory()
})
