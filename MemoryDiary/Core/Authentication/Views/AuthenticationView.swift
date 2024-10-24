//
//  AuthenticationView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct AuthenticationView: View {
    
//    var viewModel: AuthViewModel
    @Environment(AuthViewModel.self) var authVM
    
    var body: some View {
        VStack {
            switch authVM.flow {
            case .signIn:
                SignInView()
                    .environment(authVM)
            case .signUp:
                SignUpView()
                    .environment(authVM)
            case .signOut:
                Text("This is sign out view")
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environment(AuthViewModel())
}
