//
//  AuthenticationView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            switch viewModel.flow {
            case .signIn:
                SignInView(viewModel: viewModel)
            case .signUp:
                SignUpView(viewModel: viewModel)
            case .signOut:
                Text("This is sign out view")
            }
        }
    }
}

#Preview {
    AuthenticationView(viewModel: AuthViewModel())
}
