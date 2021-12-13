//
//  GenericsBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 13.12.2021..
//

import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "hello world")
    
    @Published var genericStringModel = GenericModel(info: "Hello world")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        
        genericBoolModel = genericBoolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack{
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack{
            GenericView(content: Text("custom content"), title: "new view")
            
            Text(vm.stringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
