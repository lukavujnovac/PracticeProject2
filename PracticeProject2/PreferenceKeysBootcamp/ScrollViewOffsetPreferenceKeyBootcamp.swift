//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 13.12.2021..
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader {geo in 
                    Text("")
                        .preference(
                            key: ScrollViewOffsetPreferenceKey.self,
                            value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                action(value)
            }
            
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "new title here"
    
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView{
            VStack{
                titleLayer
                    .opacity(Double(scrollViewOffset / 63.0))
                    .onScrollViewOffsetChange { value in
                        withAnimation(.easeInOut) {
                            self.scrollViewOffset = value
                        }
                    }
                    
                
                contentLayer
                
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay(navBarLayer 
                    .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
                 ,alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootcamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) {_ in 
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}
