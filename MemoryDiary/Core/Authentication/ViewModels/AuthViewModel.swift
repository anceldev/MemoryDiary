//
//  AuthViewModel.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Foundation
import Observation

enum AuthenticationState{
    case authenticated
    case authenticating
    case unauthenticated
}
enum AuthenticationFlow {
    case signIn
    case signUp
    case signOut
}

enum AuthenticationError: Error {
    case userNotExists
}

@Observable
final class AuthViewModel {
    var user: User?
    var state: AuthenticationState = .unauthenticated
    var flow: AuthenticationFlow = .signIn
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    @MainActor
    func login() {
        Task {
            switch flow {
            case .signIn:
                print("Trying to sign in")
            case .signUp:
                try await signUp()
            case .signOut:
                print("Trying to sign out")
            }
        }
    }

    private func signUp() async throws {
        self.state = .authenticating
        do {
            self.user = try await AppwriteManager.shared.createAccount(username: username, email: email, password: password)
            print("User is: ")
            print(self.user ?? "No user found")
            if self.user?.email != nil && self.user?.password != nil {
                let session = try await AppwriteManager.shared.createSession(email: self.user!.email, password: self.user!.password)
                self.state = .authenticated
            }
            throw AuthenticationError.userNotExists
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
