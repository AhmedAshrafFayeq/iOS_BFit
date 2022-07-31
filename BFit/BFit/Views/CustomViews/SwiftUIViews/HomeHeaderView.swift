//
//  HomeHeaderView.swift
//  BFit
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import SwiftUI

struct HeaderView: View {
    
    var showSettingsView: (()-> Void)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Ellipse()
                .fill(Color(UIColor.appThemeColor()))
                .frame(width: geometry.size.width * 1.4, height: geometry.size.height * 0.33)
                .position(x: geometry.size.width / 2.35, y: geometry.size.height * 0.1)
                .shadow(radius: 3)
                .edgesIgnoringSafeArea(.all)
                
                HStack(alignment: .top ) {
                    VStack(alignment: .leading) {
                        Text("TOP_EXERCISES_LABEL_TITLE".localized(forLanguageCode: NSLocale.preferredLanguages[0]))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Text("TOP_EXERCISES_LABEL_SUBTITLE".localized(forLanguageCode: NSLocale.preferredLanguages[0]))
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .padding(.top, 30)
                    
                    Spacer()
                
                Button(action: {
                    showSettingsView()
                    // Do something...

                }, label: {
                    SwiftUI.Image(uiImage: UIImage(systemName: "gearshape")!)
                        .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaleEffect(1.5)

                })
                .foregroundColor(Color(UIColor.white))
                .frame(width: 100, height: 100)

                }
            }

        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView{ }
    }
}
