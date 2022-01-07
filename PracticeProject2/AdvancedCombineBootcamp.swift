//
//  AdvancedCombineBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 07.01.2022..
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    //@Published var basicPublisher: String = "first publish"
    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    
    init() {
        publishFakeData()
    }
    
    func publishFakeData() {
        let items = ["one", "two", "three"]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.currentValuePublisher.send(<#T##input: String##String#>) = items[x]
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService() //bolje da smo dep injectali kroz init
    
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.currentValuePublisher
            .sink { completition in
                switch completition{
                    case .finished:
                        break
                    case .failure(let error):
                        print("ERROR: \(error)")
                }
            } receiveValue: {[weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellabels)
    }
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(vm.data, id: \.self) { 
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            }
        }
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
