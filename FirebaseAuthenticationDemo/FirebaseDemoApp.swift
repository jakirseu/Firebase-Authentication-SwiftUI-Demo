import SwiftUI
import FirebaseCore

@main
struct FirebaseDemoApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
