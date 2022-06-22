//
//  AuthView.swift
//  DemoFirebaseAFPE
//
//  Created by Kelian Daste on 22/06/2022.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        NavigationView{
            
            List{
                Section{
                    TextField("Email", text: $email)
                    SecureField("Mot de passe", text: $password)
                }
                Section{
                    Button("Connexion"){
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            print("UTILISATEUR CONNECTÉ")
                        }
                    }
                    NavigationLink(destination: CreateAccount()) {
                        Text("Créer un compte")
                    }
                }
                .navigationTitle("Connexion")
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
