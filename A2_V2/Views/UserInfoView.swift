//
//  UserInfo.swift
//  Assignment1
//
//  Created by Michael Wright on 2021-09-15.
//

import SwiftUI
import iPhoneNumberField

struct UserInfoView: View {
    
    @State private var fName = ""
    @State private var lName = ""
    @State private var address = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var avatar = ""
    @State private var age: Double = 0
    @State private var gender = 0
    @State private var birthDate = Date()
    @State private var showingAlert = false
    @State var isEditing: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    let purpleBlue = Color(red: 0.51, green: 0.25, blue: 0.94)
    let gradientStart = Color(red: 0.15, green: 0.54, blue: 0.11)
    let gradientEnd = Color(red: 0.28, green: 0.84, blue: 0.18)
    
    var genderNames = ["Male", "Female", "Other"]

    var avatars = ["kylo", "yoda", "leia", "mando"]
    var avatarNames = ["Kylo Ren", "Yoda", "Princess Leia", "Mandalorian"]

    var body: some View {
                
            ZStack{
                Image("starwarsbg11")
                     .resizable()
                     .scaledToFill()
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.80)
                
                ScrollView{
                    ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 30) {
                           ForEach(0..<avatars.count) { i in
                               Button(action:{
                                   avatar = avatars[i]
                               }){
                                let selected = avatar == avatars[i] ? Color.green : Color.white
//                                let textColor = avatar == avatars[i] ? Color.blue : Color.w
                                    VStack{
                                       Image(avatars[i])
                                            .resizable()
                                            .clipShape(Circle())
                                            .scaledToFit()
                                            .shadow(radius: 10)
                                            .overlay(Circle().stroke(selected, lineWidth: 5))
                                            .frame(width: 120)
                                        Text(avatarNames[i])
                                            .foregroundColor(selected)
                                            .frame(width: 120, alignment: .center)
                                    }
                               }
                           }
                       }.padding()
                   }.frame(height: 200)
                    
                    VStack{
                            HStack{
                                TextField("First Name", text: $fName)
                                    .textFieldStyle(TextInputStyle())

                                TextField("Last Name", text: $lName)
                                    .textFieldStyle(TextInputStyle())
                            }
                            VStack{
                                TextField("Address", text: $address)
                                    .textFieldStyle(TextInputStyle())

                                ZStack{
                                    iPhoneNumberField("(000) 000-0000", text: $phone, isEditing: $isEditing)
                                        .flagHidden(false)
                                        .flagSelectable(true)
                                        .maximumDigits(10)
                                        .font(UIFont(size: 15, weight: .medium, design: .monospaced))
                                        .foregroundColor(Color.green)
                                        .clearButtonMode(.whileEditing)
                                        .onClear { _ in isEditing.toggle() }
                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                        .background(Color.white)
                                        .accentColor(Color.green)
                                        .cornerRadius(15)
                                        .shadow(radius: 3, y: 1)
                                        .padding(6)
                                        .disableAutocorrection(true)
                                
                                    //Temporary fix to broken iPhoneNumberField placerholder text
                                    Text("(000) 000-0000")
                                        .opacity(0.3)
                                        .frame(width: UIScreen.main.bounds.size.width - 180, alignment: .leading)
                                        .opacity(phone.count == 0 ? 1 : 0)
                                        .zIndex(0)
                                        .disableAutocorrection(true)
                                        .font(.system(size: 15, weight: .medium, design: .monospaced))
                                }

                                TextField("Email", text: $email)
                                    .textFieldStyle(TextInputStyle())

                                Text("Age")
                                    .padding(6)
                                    .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)

                                Slider(value: $age, in: 0...100)
                                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                    .accentColor(Color.green)

                                Text("\(age, specifier: "%.f")")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 35, weight: .medium, design: .monospaced))

                                Group{
                                    Picker(selection: $gender, label: Text("Gender")) {
                                        Text("Male").tag(0)
                                        Text("Female").tag(1)
                                        Text("Other").tag(2)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                                    .accentColor(Color.green)
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 15, weight: .medium, design: .monospaced))
                                    
                                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                                        Text("Date of Birth")
                                        }
                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                        .accentColor(Color.green)
                                }
                            
                                Button(action:{
                                    addNewPerson()
                                    showingAlert = true
                                }){
                                    ZStack{
                                        Rectangle()
                                            .fill(LinearGradient(
                                              gradient: .init(colors: [gradientStart, gradientEnd]),
                                              startPoint: .init(x: 0.2, y: 0),
                                              endPoint: .init(x: 0.9, y: 0.2)
                                            ))
                                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 70)
                                            .cornerRadius(10)
                                            .shadow(radius: 3, y: 1)
                                        Text("Submit")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                                    }
                                }
                                .foregroundColor(Color.white)
                                .alert(isPresented: $showingAlert) {
                                    Alert(
                                        title: Text("Thank you,\n \(fName + " " + lName), \n (\(email)), \n for your time"),
                                        dismissButton: .default(Text("Ok"))
                                    )
                                }
                                .padding(10)
                                
                                Group{
                                                                    
                                    Text("Name: \(fName) \(lName)")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Address: \(address)")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Phone Number: \(phone)")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Email: \(email)")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Age: \(age, specifier: "%.f")")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Gender: \(self.genderNames[gender])")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                    Text("Date of Birth: \(birthDate, formatter: dateFormatter)")
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                                }
                            }
                        }.padding(10)
                    }
                    .navigationBarTitle("Enter Player Info")
                }
        }
    
        func addNewPerson(){
            //request access to the AppDelegate object - instansiated once and only once
            let mainDelegate = UIApplication.shared.delegate as! AppDelegate
            
            mainDelegate.saveEntry(fName : fName, lName: lName, address: address, phoneNum: phone, email: email, age: age, gender: genderNames[gender], birthDate: birthDate, avatar: avatar)
    
            //rememberEnteredData()
        }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextInputStyle: TextFieldStyle {
  let purpleBlue = Color(red: 0.51, green: 0.25, blue: 0.94)

  func _body(configuration: TextField<_Label>) -> some View {
    configuration
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3, y: 1)
        .padding(6)
        .accentColor(Color.green)
        .foregroundColor(Color.green)
        .font(.system(size: 15, weight: .medium, design: .monospaced))
        .disableAutocorrection(true)
  }
}





////
////  UserInfo.swift
////  Assignment1
////
////  Created by Michael Wright on 2021-09-15.
////
//
//import SwiftUI
////import iPhoneNumberField
//
//struct UserInfoView: View {
//
//    @State private var fName = ""
//    @State private var lName = ""
//    @State private var address = ""
//    @State private var phone = ""
//    @State private var email = ""
//    @State private var age: Double = 0
//    @State private var gender = 0
//    @State private var birthDate = Date()
//    @State private var avatar = ""
//
//    @State private var showingAlert = false
//    @State var isEditing: Bool = false
//
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter
//    }
//
//    let purpleBlue = Color(red: 0.51, green: 0.25, blue: 0.94)
//    let gradientStart = Color(red: 0.81, green: 0.23, blue: 1.35)
//    let gradientEnd = Color(red: 0.36, green: 0.23, blue: 1.95)
//
//    var genderNames = ["Male", "Female", "Other"]
//
//    var avatars = ["kylo", "yoda", "leia", "kylo"]
//
//
//
//    var body: some View {
//
//            ZStack{
//                Image("manspace")
//                     .resizable()
//                     .scaledToFill()
//                     .edgesIgnoringSafeArea(.all)
//                     .opacity(0.30)
//
//                ScrollView{
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 30) {
//                                        ForEach(0..<avatars.count) { i in
//                                            Button(action:{
//                                                avatar = avatars[i]
//                                            }){
//                                                if( avatar == avatars[i] ){
//                                                    Image(avatars[i])
//                                                         .resizable()
//                                                         .clipShape(Circle())
//                                                         .scaledToFit()
//                                                         .shadow(radius: 10)
//                                                         .overlay(Circle().stroke(Color.blue, lineWidth: 5))
//                                                         .frame(width: 120)
//                                                } else {
//                                                    Image(avatars[i])
//                                                         .resizable()
//                                                         .clipShape(Circle())
//                                                         .scaledToFit()
//                                                         .shadow(radius: 10)
//                                                         .overlay(Circle().stroke(Color.white, lineWidth: 5))
//                                                         .frame(width: 120)
//                                                }
//                                            }
//                                        }
//                                    }.padding()
//                                }.frame(height: 200)
//
//                    VStack{
//                            HStack{
//                                TextField("First Name", text: $fName)
//                                    .textFieldStyle(TextInputStyle())
//
//                                TextField("Last Name", text: $lName)
//                                    .textFieldStyle(TextInputStyle())
//                            }
//                            VStack{
//                                TextField("Address", text: $address)
//                                    .textFieldStyle(TextInputStyle())
//
//                                ZStack{
////                                    iPhoneNumberField("(000) 000-0000", text: $phonenumber, isEditing: $isEditing)
////                                        .flagHidden(false)
////                                        .flagSelectable(true)
////                                        .maximumDigits(10)
////                                        .font(UIFont(size: 15, weight: .medium, design: .monospaced))
////                                        .foregroundColor(purpleBlue)
////                                        .clearButtonMode(.whileEditing)
////                                        .onClear { _ in isEditing.toggle() }
////                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
////                                        .background(Color.white)
////                                        .accentColor(purpleBlue)
////                                        .cornerRadius(15)
////                                        .shadow(radius: 3, y: 1)
////                                        .padding(6)
////                                        .disableAutocorrection(true)
//
//                                    //Temporary fix to broken iPhoneNumberField placerholder text
//                                    Text("(000) 000-0000")
//                                        .opacity(0.3)
//                                        .frame(width: UIScreen.main.bounds.size.width - 180, alignment: .leading)
//                                        .opacity(phonenumber.count == 0 ? 1 : 0)
//                                        .zIndex(0)
//                                        .disableAutocorrection(true)
//                                        .font(.system(size: 15, weight: .medium, design: .monospaced))
//                                }
//
//                                TextField("Email", text: $email)
//                                    .textFieldStyle(TextInputStyle())
//
//                                Text("Age")
//                                    .padding(6)
//                                    .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//
//                                Slider(value: $age, in: 0...100)
//                                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
//                                    .accentColor(purpleBlue)
//
//                                Text("\(age, specifier: "%.f")")
//                                    .foregroundColor(purpleBlue)
//                                    .font(.system(size: 35, weight: .medium, design: .monospaced))
//
//                                Group{
//                                    Picker(selection: $gender, label: Text("Gender")) {
//                                        Text("Male").tag(0)
//                                        Text("Female").tag(1)
//                                        Text("Other").tag(2)
//                                    }
//                                    .pickerStyle(SegmentedPickerStyle())
//                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
//                                    .accentColor(purpleBlue)
//                                    .foregroundColor(purpleBlue)
//                                    .font(.system(size: 15, weight: .medium, design: .monospaced))
//
//                                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
//                                        Text("Date of Birth")
//                                        }
//                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
//                                        .accentColor(purpleBlue)
//                                }
//
//
//
//                                Button(action:{
//                                    showingAlert = true
//                                }){
//                                    ZStack{
//                                        Rectangle()
//                                            .fill(LinearGradient(
//                                              gradient: .init(colors: [gradientStart, gradientEnd]),
//                                              startPoint: .init(x: 0.2, y: 0),
//                                              endPoint: .init(x: 0.9, y: 0.2)
//                                            ))
//                                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 70)
//                                            .cornerRadius(10)
//                                            .shadow(radius: 3, y: 1)
//                                        Text("Submit")
//                                            .foregroundColor(Color.white)
//                                            .font(.system(size: 20, weight: .bold, design: .monospaced))
//                                    }
//                                }
//                                .foregroundColor(Color.white)
//                                .alert(isPresented: $showingAlert) {
//                                    Alert(
//                                        title: Text("Thank you,\n \(fName + " " + lName), \n (\(email)), \n for your time"),
//                                        dismissButton: .default(Text("Ok"))
//                                    )
//                                }
//                                .padding(10)
//
//                                Group{
//                                    Text("Name: \(fName) \(lName)")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Address: \(address)")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Phone Number: \(phone)")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Email: \(email)")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Age: \(age, specifier: "%.f")")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Gender: \(self.genderNames[gender])")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                    Text("Date of Birth: \(birthDate, formatter: dateFormatter)")
//                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                                        .frame(width: UIScreen.main.bounds.size.width - 40, alignment: .leading)
//                                }
//                            }
//                        }.padding(10)
//                    }
//                    .navigationBarTitle("Choose Your Character")
//                }
//        }
//
////    func addNewPerson(){
////        //request access to the AppDelegate object - instansiated once and only once
////        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
////
////        mainDelegate.saveEntry(fName : fName, lName: lName, address: address, phoneNum: phone, email: email, age: age, gender: genderNames[gender], birthDate: birthDate, avatar: avatar)
////
////
////        //rememberEnteredData()
////    }
//
////    func rememberEnteredData(){
////        let defaults = UserDefaults.standard
////        defaults.set(self.fname, forKey: "firstName")
////        defaults.set(self.lname, forKey: "lastName")
////        defaults.set(self.address, forKey: "address")
////        //defaults.set(self.email, forKey:"email")
////        defaults.set(self.phonenumber, forKey: "phone")
////        defaults.set(self.age, forKey: "age")
////        defaults.set(self.gender, forKey: "gender")
////        defaults.set(self.birthDate, forKey: "birthDate")
////        defaults.set(self.avatar, forKey: "avatar")
////        defaults.synchronize()
////    }
//}
//
//struct UserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct TextInputStyle: TextFieldStyle {
//  let purpleBlue = Color(red: 0.51, green: 0.25, blue: 0.94)
//
//  func _body(configuration: TextField<_Label>) -> some View {
//    configuration
//        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
//        .background(Color.white)
//        .cornerRadius(15)
//        .shadow(radius: 3, y: 1)
//        .padding(6)
//        .accentColor(purpleBlue)
//        .foregroundColor(purpleBlue)
//        .font(.system(size: 15, weight: .medium, design: .monospaced))
//        .disableAutocorrection(true)
//  }
//}
