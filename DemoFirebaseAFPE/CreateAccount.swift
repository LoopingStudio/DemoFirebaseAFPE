//
//  AuthView.swift
//  DemoFirebaseAFPE
//
//  Created by Kelian Daste on 22/06/2022.
//

import SwiftUI
import FirebaseAuth

struct CreateAccount: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var isActive = false
    var body: some View {
        List{
            Section{
                TextField("Email", text: $email)
                SecureField("Mot de passe", text: $password)
                SecureField("Confirmer mot de passe", text: $password)
            }
            Section{
                Button("Create Account"){
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            //ERROR
                            print(error.localizedDescription)
                        }
                        if let user = Auth.auth().currentUser {
                            
                        }
                    }
                }
            }
            .navigationTitle("Connexion")
        }
    }
}
