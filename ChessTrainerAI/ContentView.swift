import SwiftUI

struct ContentView: View {
    @State private var selection: String? = "Home"

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink("Home", value: "Home")
                NavigationLink("Training", value: "Training")
            }
            .navigationTitle("Menu")
            .frame(minWidth: 200)
        } detail: {
            if selection == "Home" {
                HomeView()
            } else if selection == "Training" {
                TrainingView()
            } else {
                Text("Select a menu item")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}
