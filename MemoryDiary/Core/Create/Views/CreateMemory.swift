//
//  CreateMemory.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 24/10/24.
//

import Foundation
import SwiftUI

struct CreateMemory: View {
    enum FocusedField: Hashable {
        case title, tag, content
    }
    @State private var title = ""
    @State private var tag = ""
    @State private var content = ""
    @State private var selectedDate: Date?
    
    @State private var tags: [String] = []
    
    @FocusState private var focused: FocusedField?
    @State private var selectedButton: ToolButtons?
    
    @State private var showDatePicker = false
    @State var memoryVM = MemorieViewModel()
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter
    }
    
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
//                        if selectedDate != nil {
//                            Label((selectedDate?.formatted(dateFormatter))!, systemImage: "calendar")
//                        }
                    }
                    VStack {
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
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                        (ToolButtons.content, { focused = .content }),
                        (ToolButtons.tag, { focused = .tag }),
                        (ToolButtons.mappin, { print("Adding location...")}),
                        (ToolButtons.date, { showDatePicker = true })
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
                        print("Saving...")
                        create()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("Canceling...")
                        
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red.opacity(0.45))
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showDatePicker) {
                CustomDatePicker(selectedDate: $selectedDate, button: $selectedButton)
            }
        }
    }
    
    private func create() {
        Task {
            do {
                try await memoryVM.createDocument(headerBackground: nil, backgroundShape: .circle, title: title, content: content, timestamp: selectedDate, location: nil, tags: tags)
                self.title = ""
                self.content = ""
                self.selectedDate = nil
                self.tags = []
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
#Preview(body: {
    CreateMemory()
})
