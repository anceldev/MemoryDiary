//
//  CreateMemory.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 24/10/24.
//

import SwiftUI


struct CreateMemory: View {
    enum FocusedField: Hashable {
        case title, tag, content
    }
    @State private var title = ""
    @State private var tag = ""
    @State private var content = ""
    @State private var tags: [String] = []
    
    @FocusState private var focused: FocusedField?
    @State private var selectedButton: ToolButtons?
    
    init() {
        UINavigationBar.appearance().titleTextAttributes =  [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
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
                        .frame(maxWidth: .infinity, alignment: .leading)

                        if selectedButton == .tag {
                            TextField("Add a tag", text: $tag)
                                .focused($focused, equals: .tag)
                                .textInputAutocapitalization(.never)
                                .onSubmit {
                                    tags.append(tag.trimmingCharacters(in: .whitespacesAndNewlines))
                                    tag = ""
                                    focused = .tag
                                }
                                .tint(.gray1.opacity(0.7))
                                .foregroundStyle(.white)
                        }
                    }
                    if selectedButton == .content {
                        TextEditor(text: $content)
                            .focused($focused, equals: .content)
                            .scrollContentBackground(.hidden)
                            .background(.bg)
                            .tint(.gray1)
                            .foregroundStyle(.white)
                    } else {
                        Text(content)
                    }
                    Spacer()
                }
                .padding()
                .onChange(of: focused, { _, newValue in
                    switch newValue {
                    case .title:
                        selectedButton = .title
                    case .tag:
                        selectedButton = .tag
                    case .content:
                        selectedButton = .content
                    case .none:
                        selectedButton = nil
                    }
                })
                VStack {
                    Spacer()
                    ToolsBar(selectedButton: $selectedButton, toolButtons: [
                        (ToolButtons.photo, { print("Adding photo...")}),
                        (ToolButtons.title, {
                            focused = .title
                        }),
                        (ToolButtons.content, { focused = .content }),
                        (ToolButtons.tag, { focused = .tag }),
                        (ToolButtons.mappin, { print("Adding location...")}),
                        (ToolButtons.date, { print("Adding date...")})
                    ])
                    .padding(.bottom, 10)
                }
            }
            .background(.bg)
            .navigationTitle("Create new memory")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Done...")
                    } label: {
                        Text("Save")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("Cancel...")
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red.opacity(0.45))
                            .fontWeight(.semibold)
                    }

                }
            }
        }
    }
}
#Preview(body: {
    CreateMemory()
})
