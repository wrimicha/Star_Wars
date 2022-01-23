//
//  UserDetailsView.swift
//  A2_V2
//
//  Created by Michael Wright on 2021-10-16.
//

import SwiftUI

struct UserDetailsView: View {

    var person: Entries
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
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
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
            
                    VStack {
                        
                        Image(person.avatar ?? "kylo")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFit()
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            .frame(width: 120, alignment: .leading)

                        Text("Name: " + person.fName! + " " + person.lName!)
                            .frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        Text("Email: " + person.email!)
                            .frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        Text("Gender: " + person.gender!)
                            .frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        Text("Phone: " + person.phone!)
                            .frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        Text("Age: " + String(format: "%.f", person.age))
                            .frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        HStack{
                            Text("Birthdate: ")
                            Text(person.birthDate!,formatter: dateFormatter)
                        }.frame(width: UIScreen.main.bounds.size.width - 120, height: 30, alignment: .leading)
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 150, trailing: 20))
                    .multilineTextAlignment(.center)
                
                    }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
                .navigationBarTitle("Player Info")
            }
    }
