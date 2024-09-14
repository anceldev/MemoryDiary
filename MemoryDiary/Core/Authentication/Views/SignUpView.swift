//
//  SignUpView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Bindable var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Login")
            TextField("Username", text: $viewModel.username)
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
            Button(action: {
                viewModel.login()
            }, label: {
                Text("Login")
            })
        }
        .padding()
    }

}
