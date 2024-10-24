//
//  CustomTabBar.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 24/10/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case read = "Read"
    case add = "Add"
    case profile = "Profile"
    
    var icon: String {
        switch self {
        case .read:
            "book"
        case .add:
            "plus"
        case .profile:
            "person"
        }
    }
}

struct TabBarButton: View {
    var animation: Namespace.ID
    var tab: Tab
    @Binding var selectedTab: Tab
    var body: some View {
        Button {
            withAnimation(.spring) {
                self.selectedTab = tab
            }
        } label: {
            VStack(spacing: 0) {
                Image(systemName: tab.icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .foregroundStyle(selectedTab == tab ? .gray : .white)
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(animation: animation, tab: .read, selectedTab: $selectedTab)
            TabBarButton(animation: animation, tab: .add, selectedTab: $selectedTab)
            TabBarButton(animation: animation, tab: .profile, selectedTab: $selectedTab)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .padding(.horizontal, 15)
        .background(.black)
    }
}
#Preview(traits: .sizeThatFitsLayout, body: {
    CustomTabBar(selectedTab: .constant(.add))
})

