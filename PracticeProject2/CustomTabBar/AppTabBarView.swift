//
//  AppTabBarView.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 14.12.2021..
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) { 
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            Color.blue
                .tabBarItem(tab: .favourites, selection: $tabSelection)
            
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
            Color.orange
                .tabBarItem(tab: .messages, selection: $tabSelection)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppTabBarView()
    }
}

struct Home: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 30){
                ForEach(0..<100) {x in 
                    HStack {
                        Text("x")
                        Image(systemName: "house")
                    }
                }
            }
        }
    }
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) { 
            Color.red
                .tabItem { 
                    Image(systemName: "house")
                    Text("home")
                }
            
            Color.blue
                .tabItem { 
                    Image(systemName: "heart")
                    Text("favourites")
                }
            
            Color.orange
                .tabItem { 
                    Image(systemName: "person")
                    Text("profile")
                }
        }
    }
}
