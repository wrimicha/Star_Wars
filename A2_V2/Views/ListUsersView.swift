import SwiftUI

struct EntriesRow: View {
    var person: Entries
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) var context

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    
    var body: some View{
            HStack {
                Image(person.avatar ?? "kylo")
                    //.renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFit()
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .frame(width: 75)
                    .padding(20)

                VStack() {
                    Text(person.fName! + " " + person.lName!)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 300, height: 30, alignment: .leading)
                }
            }
//            .onLongPressGesture {
//                removeEntry()
//            }
            .navigationTitle("Players")
        }
    func removeEntry() {
            context.delete(person)
            try? context.save()
    }
}

struct ItemCell: View {

    var item: String
    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 4)
                .shadow(color: Color.black, radius: 3, x: 3, y: 3)

            HStack(alignment: .center) {
                Text(item)
            }.font(.body)
        }
    }
}


struct ListUsersView: View {
    @Environment (\.managedObjectContext) var context
    @FetchRequest(entity: Entries.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Entries.lName, ascending: true)])
    var people : FetchedResults<Entries>

    let gradientStart = Color(red: 0.25, green: 0.40, blue: 0.57)
    let gradientEnd = Color(red: 0.15, green: 0.64, blue: 1.06)
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {

           ZStack {
                Image("starwarsbg11")
                     .resizable()
                     .scaledToFill()
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.80)
                List(people, id: \.self) { p in
                   NavigationLink(destination: UserDetailsView(person: p)) {
                    EntriesRow(person: p)
                      }
               }
           }
        }
}

struct ViewData_Previews: PreviewProvider {
    static var previews: some View {
        ListUsersView()
    }
}
