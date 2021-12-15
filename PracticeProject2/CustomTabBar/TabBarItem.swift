//
//  TabBarItem.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 14.12.2021..
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favourites, profile, messages
    
    var iconName: String  {
        switch self {
            case .home: return "house"
            case .favourites: return "heart"
            case .profile: return "person"
            case .messages: return "message"
        }
    }
    
    var title: String  {
        switch self {
            case .home: return "home"
            case .favourites: return "favourites"
            case .profile: return "profile"
            case .messages: return "message"
        }
    }
    
    var color: Color  {
        switch self {
            case .home: return .red
            case .favourites: return .blue
            case .profile: return .green
            case .messages: return .orange
        }
    }
}
