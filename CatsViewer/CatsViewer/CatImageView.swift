//
//  CatImageView.swift
//  CatsViewer
//
//  Created by Danylo Burliai on 19.05.2024.
//

import SwiftUI
import FirebaseCrashlytics
import FirebasePerformance

struct CatImageView: View {
    let url: String
    let contentMode: ContentMode
    
    var body: some View {
        let trace = Performance.startTrace(name: "IMAGE_LOAD_TIME")
        trace?.start()
        return AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            ProgressView()
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 300)
        .onAppear() {
            trace?.stop()
            Crashlytics.crashlytics().log("Image finished loading")
        }
    }
}

#Preview {
    CatImageView(url: "https://25.media.tumblr.com/tumblr_krww7pEgmK1qa9hjso1_1280.jpg", contentMode: .fill)
}
