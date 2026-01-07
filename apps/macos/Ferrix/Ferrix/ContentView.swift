//
//  ContentView.swift
//  Ferrix
//
//  Created by Mehran Taslimi on 1404/10/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(Ferrix.hello())
                .font(.title)
        }
    }
}

#Preview {
    ContentView()
}

