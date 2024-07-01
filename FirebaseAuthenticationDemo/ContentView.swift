import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if authViewModel.isLoggedIn {
                LoggedInView()
            } else {
                switch authViewModel.flow {
                case .login:
                    LoginView()
                    
                case .signUp:
                    SignUpView()
                case .resetPass:
                    ResetView()
                    
                }
                
            }
        }
        .padding()
        .alert(isPresented: .constant(!authViewModel.errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(authViewModel.errorMessage), dismissButton: .default(Text("OK")) {
                authViewModel.errorMessage = ""
            })
        }
    }
}

struct LoggedInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Welcome, \(authViewModel.email)!")
            Button(action: authViewModel.signOut) {
                Text("Sign Out")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignUP = false
    var body: some View {
        VStack {
            
            HStack{
                Image(systemName: "envelope")
                    .frame(width: 30)
                TextField("Email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 5)
            
            HStack{
                Image(systemName: "lock")
                    .frame(width: 30)
                SecureField("Password", text: $authViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("Forgot your password?")
                
                Button(action: {
                    withAnimation {
                        authViewModel.flow = .resetPass
                    }
                }, label: {
                    Text("Reset now.")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                })
            }
            .padding(10)
            
            
            if authViewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: authViewModel.signIn) {
                    Text("Sign In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Don't have an account yet?")
                    
                    Button(action: {
                        withAnimation {
                            authViewModel.flow = .signUp
                        }
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    })
                }
                .padding(10)
                
                
                
                
            }
        }
    }
}


struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
            HStack{
                Image(systemName: "envelope")
                    .frame(width: 30)
                TextField("Email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 5)
            
            HStack{
                Image(systemName: "lock")
                    .frame(width: 30)
                SecureField("Password", text: $authViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 5)
            
            if authViewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: authViewModel.signUp) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }
            
            HStack {
                Text("Already have an account?")
                
                Button(action: {
                    withAnimation {
                        authViewModel.flow = .login
                    }
                }, label: {
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                })
            }
            .padding(10)
            
        }
    }
}

struct ResetView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Enter your email address to reset your password.")
            HStack{
                Image(systemName: "envelope")
                    .frame(width: 30)
                TextField("Email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 5)
            
            
            
            if authViewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: authViewModel.resetPassword) {
                    Text("Reset Password")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }
            
            HStack {
                Text("Already reset your password?")
                
                Button(action: {
                    withAnimation {
                        authViewModel.flow = .login
                    }
                }, label: {
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                })
            }
            .padding(10)
            
        }
    }
}


#Preview(){
    ContentView()
        .environmentObject(AuthViewModel())
}
