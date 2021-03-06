//
//  AuthenticationScreen.swift
//  SwiftKitDemo
//
//  Created by Daniel Saidi on 2020-04-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftKit

struct AuthenticationScreen: View {
    
    init() {
        auth = Authentication(id: "demo-auth")
        authReason = "SwiftKit will not use this information."
        biometricService = BiometricAuthenticationService()
        cachedService = CachedAuthenticationServiceProxy(baseService: biometricService)
    }
    
    @State private var resultText = ""
    
    private let auth: Authentication
    private let authReason: String
    private let biometricService: BiometricAuthenticationService
    private let cachedService: CachedAuthenticationServiceProxy
    
    var body: some View {
        List {
            ResultText(resultText)
            ListButton(
                text: "Perform biometric authentication",
                description: "This authentication will be performed every time you tap the button.",
                action: performBiometricAuthentication)
            ListButton(
                text: "Perform cached authentication",
                description: "This authentication will cache any successful authentication operation and not ask you again until you reset the authentication cache.",
                action: performCachedAuthentication)
            ListButton(
                text: "Reset authentication cache",
                description: "Resetting the authentication cache will make the cached service perform an actual authentication the next time you tap the button.",
                action: resetAuthenticationCache)
        }.navigationBarTitle("Authentication")
    }
}

struct AuthenticationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationScreen()
    }
}

extension AuthenticationScreen {
    
    func performCachedAuthentication() {
        cachedService.authenticateUser(for: auth, reason: authReason, completion: handleResult)
    }
    
    func performBiometricAuthentication() {
        biometricService.authenticateUser(for: auth, reason: authReason, completion: handleResult)
    }
    
    func resetAuthenticationCache() {
        cachedService.resetUserAuthentication(for: auth)
    }
    
    func handleResult(_ result: Result<Void, Error>) {
        switch result {
        case .failure(let error): self.resultText = "Authentication failed with error \(error.localizedDescription)"
        case .success: self.resultText = "Authentication succeeded"
        }
    }
}
