//
//  CustomNavView.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 15.12.2021..
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView{
            CustomNavBarContainerView { 
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView { 
            Color.red.ignoresSafeArea()
        }
    }
}

//za swipe gesture
extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
