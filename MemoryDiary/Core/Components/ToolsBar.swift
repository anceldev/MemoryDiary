//
//  ToolsBar.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 24/10/24.
//

import SwiftUI

enum ToolButtons {
    case photo, title, tag, mappin, date, content
    var title: String {
        switch self {
        case .photo: "Image"
        case .title: "Title"
        case .tag: "Tag"
        case .mappin: "Map pin"
        case .date: "Date"
        case .content: "Text"
        }
    }
    var icon: String {
        switch self {
        case .photo: "photo"
        case .title: "t.circle"
        case .tag: "number"
        case .mappin: "mappin"
        case .date: "calendar"
        case .content: "text.justify.left"
        }
    }
}

struct ToolButton: View {
    let action: () -> Void
    let toolButton: ToolButtons
    @Binding var selectedButton: ToolButtons?
    var body: some View {
        Button {
            selectedButton = toolButton
            action()
        } label: {
            Label(toolButton.title, systemImage: toolButton.icon)
                .labelStyle(.iconOnly)
                .foregroundStyle(selectedButton == toolButton ? .white : .gray1)
                .font(.title2)
        }
    }
}

struct ToolsBar: View {
    @Binding var selectedButton: ToolButtons?
    let toolButtons: [(ToolButtons, () -> Void)]
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            VStack(alignment: .center) {
                HStack(spacing: 12){
                    ForEach(toolButtons, id: \.0.icon) { button in
                        ToolButton(action: button.1, toolButton: button.0, selectedButton: $selectedButton)
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: size.width * 0.6)
                .frame(height: 38)
//                .background(.bg.opacity(0.7))
                .background(.toolbar)
                .clipShape(
                    RoundedRectangle(cornerRadius: 5)
                )
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .frame(maxWidth: .infinity)
            
        }
        .frame(height: 30)
        .frame(maxWidth: .infinity)
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    ToolsBar(selectedButton: .constant(.content) ,toolButtons: [
        (ToolButtons.photo, { print("Adding photo...")}),
        (ToolButtons.title, { print("Adding title...") }),
        (ToolButtons.content, { print("Adding text...")}),
        (ToolButtons.tag, { print("Adding tag") }),
        (ToolButtons.mappin, { print("Adding location...")}),
        (ToolButtons.date, { print("Adding date...")})
    ])
})
