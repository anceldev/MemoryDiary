//
//  AuthenticatedView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @State var authVM = AuthViewModel()
    
    var body: some View {
        VStack {
            switch authVM.state {
            case .authenticated:
                MainTab()
                    .environment(authVM)
            case .authenticating:
                ProgressView()
            case .unauthenticated:
                AuthenticationView()
                    .environment(authVM)
            }
        }
    }
}

#Preview {
    @Previewable @State var authVM = AuthViewModel()
    authVM.state = .authenticated
    return AuthenticatedView(authVM: authVM)
}
