//
//  SignUpView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignUpView: View {
    enum FocusedField: Hashable {
        case username, email, password
    }
    
    @Environment(AuthViewModel.self) var authVM
    @FocusState private var focused: FocusedField?
    var body: some View {
        @Bindable var viewModel = authVM
        VStack {
            Text("Login")
            TextField("Username", text: $viewModel.username)
                .focused($focused, equals: .username)
                .onSubmit { focused = .email }
            TextField("Email", text: $viewModel.email)
                .focused($focused, equals: .email)
                .onSubmit { focused = .password }
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
                .focused($focused, equals: .password)
                .onSubmit { focused = nil }
            Button(action: {
//                viewModel.authAction()
                withAnimation(.easeIn) {
                    signUp()
                }
            }, label: {
                Text("Login")
            })
        }
        .padding()
    }
    private func signUp() {
        if authVM.username.isEmpty {
            focused = .username
        } else if authVM.email.isEmpty {
            focused = .email
        } else if authVM.password.isEmpty {
            focused = .password
        } else {
            authVM.authAction()
        }
    }

}
