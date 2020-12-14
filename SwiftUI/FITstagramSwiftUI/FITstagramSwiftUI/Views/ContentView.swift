//
//  ContentView.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                FeedView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Feed")
            }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
