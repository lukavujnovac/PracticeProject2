//
//  DependencyInjecitionBootcamp.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 21.12.2021..
//

import SwiftUI
import Combine

struct PostModel: Identifiable ,Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}


class ProductionDataService: DataServiceProtocol {
    
//    static let instance = ProductionDataService()
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    
    let mockData: [PostModel] 
    
    init(data: [PostModel]?) {
        self.mockData = data ?? [
            PostModel(userId: 1, id: 1, title: "one", body: "one"),
            PostModel(userId: 2, id: 2, title: "two", body: "two")
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        Just(mockData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()  
    }
    
    
}

class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)

    }
    
}

struct DependencyInjecitionBootcamp: View {
    
    @StateObject var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(vm.dataArray) {post in 
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjecitionBootcamp_Previews: PreviewProvider {
    
    static let dataService = MockDataService() //ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    static var previews: some View {
        DependencyInjecitionBootcamp(dataService: dataService)
    }
}
