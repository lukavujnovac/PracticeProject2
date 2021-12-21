//
//  ProtocolsBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 19.12.2021..
//

import SwiftUI

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color  = .red
    var tertiary: Color = .purple

}

struct AlthernativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
    
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    
}

class DefaultDataSource:  ButtonDataSourceProtocol {
    var buttonText: String = "protocols are awsome"
    
    func buttonPressed() {
        print("button was pressed")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "protocols are lame"
}

struct ProtocolsBootcamp: View {
    
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
//    let colorTheme: AlthernativeColorTheme = AlthernativeColorTheme()
    let colorTheme: ColorThemeProtocol 
    let dataSource: ButtonDataSourceProtocol        
    
    var body: some View {
        ZStack {
            colorTheme.tertiary.ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}	

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
    }
}
