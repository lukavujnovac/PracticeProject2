//
//  AppNavBarView.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 15.12.2021..
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack{
                Color.orange.ignoresSafeArea()
                
                CustomNavLink { 
                    Text("navigate")
                        .customNavigationTitle("Title")
                        .customNavigationSubtitle("subtitle")
                } label: { 
                    Text("destination")
                }
            }
            .customNavBarItems(title: "Title", subtitle: "Subtitle", backButtonHidden: true)
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView{
            ZStack{
                Color.green
                    .ignoresSafeArea()
                
                NavigationLink { 
                    Text("destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: { 
                    Text("navigate")
                }

            }
            .navigationTitle("Nav title here")
        }
    }
}
