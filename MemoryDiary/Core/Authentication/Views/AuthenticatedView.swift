//
//  AuthenticatedView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @State var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            switch authViewModel.state {
            case .authenticated:
                MainTab()
            case .authenticating:
                ProgressView()
            case .unauthenticated:
                AuthenticationView(viewModel: authViewModel)
            }
        }
    }
}

#Preview {
    AuthenticatedView()
}
