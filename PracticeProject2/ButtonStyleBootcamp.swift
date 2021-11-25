//
//  ButtonStyleBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 25.11.2021..
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    let backgroundColor: Color
    
    init(scaledAmount: CGFloat, backgroundColor: Color) {
        self.scaledAmount = scaledAmount
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? backgroundColor : Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.5 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9, backgroundColor: Color = .red) -> some View {
//        self.buttonStyle(PressableButtonStyle())
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount, backgroundColor: backgroundColor))
    }
}

struct ButtonStyleBootcamp: View {
    
    var body: some View {
        Button { 
            print("")
        } label: { 
            Text("Click me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 10, y: 10)
        }
        .withPressableStyle(scaledAmount: 0.9, backgroundColor: .yellow)
//        .buttonStyle(PressableButtonStyle())
        .padding()

    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
