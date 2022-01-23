//
//  ContentView.swift
//  week3ex
//
//  Created by Michael Wright on 2021-09-21.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        
        ZStack {
            Image("starwarsbg11")
                 .resizable()
                 .scaledToFill()
                 .edgesIgnoringSafeArea(.all)
                 .opacity(0.80)
            
            
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 320)
            
                    VStack {
                        
                        Image("profile")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFit()
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            .frame(width: 120)

                        Text("Michael Wright")
                            .font(.largeTitle)
                            .foregroundColor(Color.black)

                        Text("My name is Michael Wright, I am a 3rd year Mobile Computing Student at Sheridan college. In my free time I like to listen to music, cook, and watch tv shows!")
                            .frame(height: 140)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.gray)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 100, trailing: 20))
                    }
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                    }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
                .navigationBarTitle("About Me")
            }
    }


struct AboutMe_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
