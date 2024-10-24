//
//  SignInView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignInView: View {
    enum FocusedField: Hashable {
        case email, password
    }
//    @Bindable var viewModel: AuthViewModel
    @FocusState private var focused: FocusedField?
    @Environment(AuthViewModel.self) var authVM
    var body: some View {
        @Bindable var viewModel = authVM
        VStack {
            Text("This is the SignInView")
            TextField("Email", text: $viewModel.email)
                .focused($focused, equals: .email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .onSubmit { focused = .email }
            SecureField("Password", text: $viewModel.password)
                .focused($focused, equals: .password)
                .onSubmit { focused = nil }
            Button(action: {
//                authVM.authAction()
                withAnimation(.easeIn) {
                    login()
                }
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
    private func login() {
        if authVM.email.isEmpty {
            focused = .email
        } else if authVM.password.isEmpty {
            focused = .password
        } else {
            authVM.authAction()
        }
    }
}
