//
//  DataController.swift
//  ContactApp
//
//  Created by Sithum Raveesha on 2024-11-06.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SettingsView(currency: .constant(Currencies.usd))
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
