//
//  SettingsView.swift
//  BFit
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section() {
                VStack{
                    Spacer()
                HStack{
                    SwiftUI.Image(systemName: "globe")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(Color.clear, lineWidth: 1)
                        )
                        .foregroundColor(Color(UIColor.appThemeColor()))
                    
                    Text("CHANGE_LANGUAGE".localized(forLanguageCode: NSLocale.preferredLanguages[0]))
                        .font(.system(size: 24, design: .rounded))
                        .padding()
                    Spacer()
                    Button(action: {}){
                        SwiftUI.Image(systemName:"chevron.right")
                            .font(.body)
                            .foregroundColor(Color(UIColor.appThemeColor()))
                    }
                }
                   Spacer()
                }
            }
            .frame(height: 70)
        }
        .listStyle(GroupedListStyle())
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
