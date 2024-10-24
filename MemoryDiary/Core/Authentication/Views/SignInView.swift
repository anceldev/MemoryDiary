//
//  SignInView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignInView: View {
//    @Bindable var viewModel: AuthViewModel
    @Environment(AuthViewModel.self) var authVM
    var body: some View {
        @Bindable var viewModel = authVM
        VStack {
            Text("This is the SignInView")
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
            Button(action: {
                authVM.authAction()
            }, label: {
                Text("Login")
            })
            
            Button(action: {
                withAnimation(.smooth) {
                    authVM.flow = .signUp
                }
            }, label: {
                Text("Sign up")
            })
        }
    }
}
