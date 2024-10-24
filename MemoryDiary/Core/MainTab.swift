//
//  MainTab.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI


struct MainTab: View {
    @Environment(AuthViewModel.self) var authVM
    @State var selectedTab: Tab = .add
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .read:
                    Text("Read tab")
                case .add:
                    Text("Add tab")
                case .profile:
                    VStack {
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        Text(authVM.user?.name ?? "No name")
                        Text(authVM.user?.email ?? "No email")
                        Button(role: .cancel) {
                            authVM.flow = .signOut
                            authVM.authAction()
                        } label: {
                            Text("Log out")
                        }
                    }
                }
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .background(.bg)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainTab()
        .environment(AuthViewModel())
}
