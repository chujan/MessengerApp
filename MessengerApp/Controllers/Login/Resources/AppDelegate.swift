//
//  AppDelegate.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 05/08/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return handled

    

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with Google: \(error)")
            }
            return
        }
       // guard let user = user else {
       //     return
       // }
        print("user")
        
        guard let email = user.profile?.email,
              let firstName = user.profile?.givenName,
              let lastName = user.profile?.familyName else {
                return
        }
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set("\(firstName)  \(lastName)", forKey: "name")
        
        
    
        DatabaseManager.shared.userExists(with: email, completion: { exist in
            if !exist {
                let chatUser = ChatAppUser(firstName: firstName,
                                           lastName: lastName,
                                           emailAddress: email)
                DatabaseManager.shared.insertUser(with: chatUser, completion:{ success in
                    if success {
                        
                    }
                    
                })
                                                            
            }
        })
        
            

        guard
            let authentication = user?.authentication else {
            print("Missing auth object off of google user")
            return
        }
       

       
        
        
       
        
         
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("failed to log in with google credential")
                return
            }
            print("Successfully signed in with google cred.")
            NotificationCenter.default.post(name: .didLogInNotification, object: nil)
            
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith User: GIDGoogleUser!, withError error: Error!) {
        print("Google user was disconnected")
        
    }
    

}
    
