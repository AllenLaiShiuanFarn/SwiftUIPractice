import SwiftUI

struct WolframAlphaResult: Decodable {
    let queryResult: QueryResult
    
    struct QueryResult: Decodable {
        let pods: [Pod]
        
        struct Pod: Decodable {
            let primary: Bool?
            let subPods: [SubPod]
            
            struct SubPod: Decodable {
                let plainText: String
            }
        }
    }
}

let wolframAlphaApiKey = ""
func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) {
    var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
    components.queryItems = [
        URLQueryItem(name: "input", value: query),
        URLQueryItem(name: "format", value: "plaintext"),
        URLQueryItem(name: "output", value: "JSON"),
        URLQueryItem(name: "appid", value: wolframAlphaApiKey)
    ]
    
    URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
        callback(data.flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) })
    }
    .resume()
}

func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
    wolframAlpha(query: "prime \(n)") { result in
        callback(
            result
                .flatMap {
                    $0.queryResult
                        .pods
                        .first(where: { $0.primary == .some(true) })?
                        .subPods
                        .first?
                        .plainText
                }
                .flatMap(Int.init)
        )
    }
}

//nthPrime(1_000_000) { p in
//    print(p)
//}

struct ContentView: View {
    @ObservedObject var state: AppState
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    CounterView(state: state)
                } label: {
                    Text("Counter demo")
                }
                NavigationLink {
                    FavoritePrimesView(state: state)
                } label: {
                    Text("Favorite primes")
                }
            }
            .navigationTitle("State management")
        }
    }
}

private func ordinal(_ n: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter.string(for: n) ?? ""
}

import Combine

// ObservableObject
class AppState: ObservableObject {
//    let objectWillChange = ObservableObjectPublisher()
//    var count = 0 {
//        willSet {
//            self.objectWillChange.send()
//        }
//    }
    
    @Published var count = 0
    @Published var favoritePrimes: [Int] = []
}

struct PrimeAlert: Identifiable {
    let prime: Int
    var id: Int { prime }
}

struct CounterView: View {
//    @State private var count: Int = 0
    @ObservedObject var state: AppState
    @State private var isPrimeModalShown: Bool = false
    @State private var alertNthPrime: PrimeAlert?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    state.count -= 1
                }) {
                    Text("-")
                }
                Text("\(state.count)")
                Button(action: {
                    state.count += 1
                }) {
                    Text("+")
                }
            }
            
            Button(action: {
                isPrimeModalShown = true
            }) {
                Text("Is this prime?")
            }
            
            Button(action: {
                nthPrime(state.count) { prime in
                    alertNthPrime = prime.map(PrimeAlert.init(prime:))
                }
            }) {
                Text("What is the \(ordinal(state.count)) prime?")
            }
        }
        .font(.title)
        .navigationBarTitle("Counter demo")
        .sheet(isPresented: $isPrimeModalShown,
               onDismiss: {
            isPrimeModalShown = false
        },
               content: {
            IsPrimeModalView(state: state)
        })
        .alert(item: $alertNthPrime, content: { alert in
            Alert(title: Text("The \(ordinal(state.count)) prime is \(alert.prime)"),
                  dismissButton: .default(Text("Ok")))
        })
    }
}

private func isPrime(_ p: Int) -> Bool {
    if p <= 1 { return false }
    if p <= 3 { return true }
    for i in 2...Int(sqrtf(Float(p))) {
        if p % i == 0 { return false }
    }
    return true
}

struct IsPrimeModalView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
//            Text("I don't kwno if \(state.count) is prime")
            if isPrime(state.count) {
                Text("\(state.count) is prime 🎉")
                if state.favoritePrimes.contains(state.count) {
                    Button {
                        state.favoritePrimes.removeAll(where: { $0 == state.count })
                    } label: {
                        Text("remove from favorite primes")
                    }
                } else {
                    Button {
                        state.favoritePrimes.append(state.count)
                    } label: {
                        Text("Save to favorite primes")
                    }
                }
            } else {
                Text("\(state.count) is not orime :(")
            }
        }
    }
}

struct FavoritePrimesView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        List {
            ForEach(state.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    state.favoritePrimes.remove(at: index)
                }
            })
        }
        .navigationBarTitle(Text("Favorite Primes"))
    }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView(state: AppState()))
//PlaygroundPage.current.liveView = UIHostingController(rootView: CounterView())
