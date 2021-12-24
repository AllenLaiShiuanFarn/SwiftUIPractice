import SwiftUI

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
                    EmptyView()
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
}

struct CounterView: View {
//    @State private var count: Int = 0
    @ObservedObject var state: AppState
    
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
            
            Button(action: {}) {
                Text("Is this prime?")
            }
            
            Button(action: {}) {
                Text("What is the \(ordinal(state.count)) prime?")
            }
        }
        .font(.title)
        .navigationBarTitle("Counter demo")
    }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView(state: AppState()))
//PlaygroundPage.current.liveView = UIHostingController(rootView: CounterView())
