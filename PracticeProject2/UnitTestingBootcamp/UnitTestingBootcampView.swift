//
//  UnitTestingBootcampView.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 29.12.2021..
//

import SwiftUI

struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcampView(isPremium: true)
    }
}
