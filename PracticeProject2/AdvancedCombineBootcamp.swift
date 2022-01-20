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
//    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    func publishFakeData() {
        let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
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
    
    let dataService = AdvancedCombineDataService() //bolje da smo dep injectali kroz init
    
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.passThroughPublisher
        
        // Sequence operations
        /*
//            .first()
//            .first(where: {$0 > 4})
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .last()
//            .last(where: {$0 < 4})
//            .tryLast(where: { int in
//                if int == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return int  > 1
//            })
//            .dropFirst()
//            .dropFirst(3)
//            .drop(while: {$0 < 5})
//            .tryDrop(while: { int in
//                if int == 15 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
//            .prefix(4)
//            .prefix(while: {$0 < 5})
//            .tryPrefix(while: )
//            .output(at: 4)
//            .output(in: 2..<4)
        */
        
        //Mathematic operations
        /*
//            .max()
//            .max(by: { int1, int2 in
//                return int1 < int2
//            })
//            .tryMax(by: )
//            .min()
//            .min(by: )
//            .min(by: )
//            .tryMin(by: )
        */
        
        // Filtering/reducing operations
//            .map({String($0)})
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
//            .compactMap({ int in
//                if int == 5 {
//                    return nil
//                }
//                return "\(int)" //String(int)
//            })
//            .tryCompactMap()
//            .filter({ ($0 > 3) && ($0 < 7) })
//            .tryFilter()
//            .removeDuplicates()
        
        
        
        
            .map({String($0)})
            .sink { completition in
                switch completition{
                    case .finished:
                        break
                    case .failure(let error):
                        self.error = "ERROR: \(error.localizedDescription)"
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
