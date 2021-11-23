//
//  ViewModifierBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 23.11.2021..
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    
    func withDefaultButtonFormating(backgroundColor: Color = .blue) -> some View{
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
    
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 10){
            Text("hello world")
                .font(.headline)
                .withDefaultButtonFormating(backgroundColor: .pink)
            
            Text("hello everyone")
                .font(.subheadline)
                .withDefaultButtonFormating(backgroundColor: .orange)
            
            Text("hello")
                .font(.title)
                .withDefaultButtonFormating()
        }
        .padding()
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
