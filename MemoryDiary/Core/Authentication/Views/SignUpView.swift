//
//  SignUpView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(AuthViewModel.self) var authVM
    var body: some View {
        @Bindable var viewModel = authVM
        VStack {
            Text("Login")
            TextField("Username", text: $viewModel.username)
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
            Button(action: {
                viewModel.authAction()
            }, label: {
                Text("Login")
            })
        }
        .padding()
    }

}
