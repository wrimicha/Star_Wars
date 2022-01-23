
//
//  ContentView.swift
//  Assignment1
//
//  Created by Michael Wright on 2021-09-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView {

         ZStack {
            Image("starwarsbg9")
                 .resizable()
                 .scaledToFill()
                 .edgesIgnoringSafeArea(.all)

                VStack{
                    ZStack{
                        NavigationLink(destination: UserInfoView()){
                                       Image("button1")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 350.0)
                            }
                        Text("Enter User Info")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15, weight: .medium, design: .monospaced))
                    }

                    ZStack{
                        NavigationLink(destination: AboutMeView()){
                                       Image("button1").renderingMode(.original)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 350.0)
                            }
                        Text("About Me")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15, weight: .medium, design: .monospaced))
                    }

                    ZStack{
                        NavigationLink(destination: WebsiteLinkView()){
                                       Image("button1").renderingMode(.original)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 350.0)
                            }
                        Text("Website Link")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15, weight: .medium, design: .monospaced))
                    }
                    ZStack{
                        
                        NavigationLink(destination: ListUsersView()){
                                       Image("button1").renderingMode(.original)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 350.0)
                            }
                        Text("View Users")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15, weight: .medium, design: .monospaced))
                    }
                    Spacer()
                }
            }
        } .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



////
////  ContentView.swift
////  A2
////
////  Created by Michael Wright on 2021-10-15.
////
//
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
