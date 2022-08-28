//
//  progressView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 14/01/1444 AH.
//

import SwiftUI

struct customProgressView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            VStack(spacing : 30) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .scaleEffect(2)
                Text("please wait ..")
                    .foregroundColor(.white)
            }
                
        }
            .ignoresSafeArea()
    }
}

struct progressView_Previews: PreviewProvider {
    static var previews: some View {
        customProgressView()
    }
}
