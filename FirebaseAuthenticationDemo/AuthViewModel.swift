import SwiftUI
import FirebaseAuth

enum AuthenticationFlow {
    case login
    case signUp
    case resetPass
}

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    @Published var flow: AuthenticationFlow = .login
    
    init() {
        checkAuthState()
    }
    
    func signIn() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
                self.errorMessage = ""
            }
        }
    }
    
    func signUp() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
                self.errorMessage = ""
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            email = ""
            password = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else{
                self.flow = .login
            }
        }
    }
    
    private func checkAuthState() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? ""
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}
