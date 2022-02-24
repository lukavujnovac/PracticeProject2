//
//  AdvancedCombineBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 23.02.2022..
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    @Published var basicPublisher: String = "" 
    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(1..<11)
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
//                self.basicPublisher = items[x]
//                self.currentValuePublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                } 
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    } 
    
    private func addSubscribers() {
//        dataService.$basicPublisher
//        dataService.currentValuePublisher
        dataService.passThroughPublisher
        
        //Sequence operations
//            .first()
//            .first(where: { $0 > 4})
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return int > 1
//            })
//            .last()
//            .last(where: { $0 < 4})
//            .tryLast(where: { int in
//                if int == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .dropFirst()
//            .dropFirst(3)
//            .drop(while: { $0 < 3})
//            .tryDrop(while: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
            .prefix(5)
        
            .map({String($0)})
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellabels)

    }
}

struct AdvancedCombineBootcamp: View {
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.data, id: \.self) { 
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                if !vm.error.isEmpty {
                    Text(vm.error)
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
