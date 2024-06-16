//
//  ContentView.swift
//  CatsViewer
//
//  Created by Danylo Burliai on 19.05.2024.
//

import SwiftUI
import FirebaseCrashlytics

struct ContentView: View {
    @ObservedObject var storage = Storage.instance
    
    @State var timesExpanded = 0
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(storage.urls, id: \.self) { url in
                    NavigationLink(value: url) {
                        CatImageView(url: url, contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationDestination(for: String.self,
                                   destination: { url in
                CatImageView(url: url, contentMode: .fill)
                    .onAppear() {
                        timesExpanded += 1
                        Crashlytics.crashlytics().setCustomValue(timesExpanded, forKey: "times_expanded_image")
                        Crashlytics.crashlytics().log("Image \(storage.urls.firstIndex(of: url) ?? -1) was selected")
                    }
            })
        }
        Button("Crash") {
            Crashlytics.crashlytics().log("Oh no big red shiny button pressed")
            fatalError("Crash was triggered")
        }
    }
}

#Preview {
    ContentView()
}
