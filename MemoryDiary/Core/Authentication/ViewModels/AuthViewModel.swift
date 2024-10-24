//
//  AuthViewModel.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Foundation
import Observation
import Appwrite

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

enum AuthError: Error {
    case userNotExists
    case invalidEmailPassword
}

@Observable
final class AuthViewModel {
    let user: User?
    var state: AuthenticationState = .unauthenticated
    var flow: AuthenticationFlow = .signIn
    var sessionId: String
    
    var username: String
    var email: String
    var password: String
    
    init() {
        self.user = .init(id: "", name: "", email: "", password: "")
        self.state = .unauthenticated
        self.flow = .signIn
        self.username = ""
        self.email = ""
        self.password = ""
        self.sessionId = UserDefaults.standard.string(forKey: "sessionId") ?? ""
        if !self.sessionId.isEmpty {
            Task {
                await checkForExistingSession()
            }
        }
    }
    
    @MainActor
    func authAction() {
        Task {
            do {
                switch flow {
                case .signIn:
                    try await signIn()
                case .signUp:
                    try await signUp()
                case .signOut:
                    try await signOut()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private func signIn() async throws {
        self.state = .authenticating
        do {
            if isValidEmail(email) && isValidPassword(password) {
                let session = try await AppwriteClient.shared.account.createEmailPasswordSession(email: email, password: password)
                UserDefaults.standard.setValue(session.id, forKey: "sessionId")
                self.sessionId = session.id
                let account = try await AppwriteClient.shared.account.get()
                
                self.user?.id = account.id
                self.user?.name = account.name
                self.user?.email = account.email
                self.user?.password = account.password ?? ""
            
                self.state = .authenticated
                return
            }
            throw AuthError.invalidEmailPassword
        } catch {
            self.state = .unauthenticated
            print(error.localizedDescription)
        }
    }
    private func signUp() async throws {
        self.state = .authenticating
        do {
            if isValidEmail(email) && isValidPassword(password) {
                let user = try await AppwriteClient.shared.account.create(
                    userId: ID.unique(),
                    email: email,
                    password: password,
                    name: username
                )
                let session = try await AppwriteClient.shared.account.createEmailPasswordSession(email: email, password: password)
                UserDefaults.standard.setValue(session.id, forKey: "sessionId")
                
                self.user?.id = user.id
                self.user?.name = user.name
                self.user?.email = user.email
                self.user?.password = user.password ?? ""
                self.state = .authenticated
                self.flow = .signIn
                return
            }
            throw AuthError.invalidEmailPassword
        } catch {
            self.state = .unauthenticated
            print(error.localizedDescription)
        }
    }
    private func signOut() async throws {
        do {
            let result = try await AppwriteClient.shared.account.deleteSession(sessionId: self.sessionId)
            self.email = ""
            self.password = ""
            self.state = .unauthenticated
            self.flow = .signIn
            UserDefaults.standard.setValue("", forKey: "sessionId")
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor
    private func checkForExistingSession() async {
        do {
            let account = try await AppwriteClient.shared.account.get()

            self.user?.id = account.id
            self.user?.name = account.name
            self.user?.email = account.email
            self.user?.password = account.password ?? ""

            self.state = .authenticated
        } catch {
            print("No existing session found: \(error.localizedDescription)")
        }
    }
}
