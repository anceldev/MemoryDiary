//
//  Utils.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 23/10/24.
//

import Foundation


func isValidEmail(_ email: String) -> Bool {
    let emailReges = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
    return (email.range(of: emailReges, options: .regularExpression) != nil)
}
func isValidPassword(_ password: String) -> Bool {
    let passwordReges = "[A-Z0-9a-z]{4,8}"
    return (password.range(of: passwordReges, options: .regularExpression) != nil)
}
