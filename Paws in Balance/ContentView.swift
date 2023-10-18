import SwiftUI

struct ContentView: View {
    // 1. Properties (State, Binding, ObservedObject, etc.)
    @State private var isButtonPressed = false

    var body: some View {
        // 2. Main layout
        NavigationView {
            VStack {
                // 3. Subviews or components
                headerView
                mainContentView
                footerView
            }
            .navigationTitle("Paws in Balance")
        }
    }
}

extension ContentView {
    // 4. Individual component views

    var headerView: some View {
        Text("Account Login")
            .font(.largeTitle)
            .padding()
    }

    var mainContentView: some View {
        VStack {
            Text("Main Content")
                .font(.title)
                .padding()

            Button(action: {
                isButtonPressed.toggle()
            }) {
                Text(isButtonPressed ? "Button Pressed" : "Press Me")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    var footerView: some View {
        Text("Footer")
            .font(.caption)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

