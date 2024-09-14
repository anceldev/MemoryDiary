//
//  SignInView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import SwiftUI

struct SignInView: View {
    var viewModel: AuthViewModel
    var body: some View {
        VStack {
            Text("This is the SignInView")
            Button(action: {
                withAnimation(.smooth) {
                    viewModel.flow = .signUp
                }
            }, label: {
                Text("Sign up")
            })
        }
    }
}
