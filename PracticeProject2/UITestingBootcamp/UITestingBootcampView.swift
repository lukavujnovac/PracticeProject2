//
//  UITestingBootcampView.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 05.01.2022..
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    
    let placeholderText: String = "Add your name"
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool = false
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else {return}
        currentUserIsSignedIn = true
    }
    
}

struct UITestingBootcampView: View {
    
    @StateObject private var vm = UITestingBootcampViewModel() 
    
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [Color.blue, Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: . infinity)
                        .transition(.move(edge: .trailing))
                }
                if !vm.currentUserIsSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: . infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

struct UITestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UITestingBootcampView()
    }
}

extension UITestingBootcampView {
    private var signUpLayer: some View {
        VStack{
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField")
            
            Button { 
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            } label: { 
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityIdentifier("SignUpButton")
            }
            
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Button { 
                    showAlert.toggle()
                } label: { 
                    Text("show welcome alert")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("ShowAlertButton")
                .alert(isPresented: $showAlert) { 
                    return Alert(title: Text("welcome to the app"))
                }
                
                NavigationLink(destination: Text("destination")) { 
                    Text("naviagte")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier("NavigationLinkToDestination")
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
