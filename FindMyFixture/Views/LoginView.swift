//
//  LoginView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation

import SwiftUI

struct LoginView: View {
    
    
    @StateObject var viewModel = LoginViewModel()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    Color.blue
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10.0, x: 20, y: 10)
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120 , height: 120)
                    
                }
                VStack(alignment: .leading, spacing: 15) {
                    TextField("username", text: $username)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    SecureField("password", text: $password)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                }
                .padding([.leading, .trailing], 27.5)
                
                Text("\(viewModel.message)")
                
                
                ZStack {
                    NavigationLink(destination: MainTabView(userId: viewModel.userId), isActive: $viewModel.loginSuccess, label: {
                        EmptyView()
                    })
                    
                    Button(action: {
                        guard !username.isEmpty && !password.isEmpty else {
                            showingAlert = true
                            return
                        }
                        viewModel.login(username: username, password: password) {success in
                            // alert that connection to server failed
                        }
                    }) {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Please insert username and password!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.top, 50)
                    
                }
                
                
                Spacer()
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign up")
                    }
                }
                
                
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
        
        .onAppear {
            #if DEBUG
            username = "Admin"
            password = "admin"
            #endif
        }
    }
}

enum Field: Hashable {
    case usernameField
    case passwordField
}



extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
