//
//  ContentView.swift
//  Devote
//
//  Created by MAC on 11/07/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: PROPERTY
    
    @State var task: String = ""
    @State private var showNewTaskView: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    //FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: FUNCTION
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //MARK: BODY

    var body: some View {
            NavigationView {
                ZStack {
                    //MARK: MAIN VIEW
                    VStack {
                       //MARK: HEADER
                        HStack(spacing: 10){
                            // TITLE
                            Text("DEVOTE")
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.heavy)
                                .padding(.leading,  4)
                            
                            Spacer()
                            
                            // EDIT BUTTON
                            EditButton()
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .padding(.horizontal, 10)
                                .frame(minWidth: 17, minHeight: 24)
                                .background(
                                    Capsule().stroke(Color.white, lineWidth: 2)
                                )
                            
                            
                            // APPERENCE BUTTON
                            Button(action: {
                                //: TOGLE APPERENCE
                                isDarkMode.toggle()
                                playSound(sound: "sound-tap", type: "mp3")
                                feedback.notificationOccurred(.success)
                            }, label: {
                                Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .font(.system(.title, design: .rounded))
                            })
                            
                            
                        }//: HSTACK
                        .padding()
                        .foregroundColor(.white)
                        
                        Spacer(minLength: 80)
                        
                        //MARK: NEW TASK BUTTON
                        
                        Button(action: {
                            showNewTaskView = true
                            playSound(sound: "sound-ding", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }, label: {
                        Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                            Text("New Task View")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                        })
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(gradient: Gradient(colors:[Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(Capsule())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                        
                        //MARK: TASKS
                        
                        
                        List {
                            ForEach(items) { item in
                                    ListRowItemView(item: item)
                            }
                            .onDelete(perform: deleteItems)
                        }//: LIST
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0)
                        .frame(maxWidth: 640)
                    }//: VSTACK
                    .blur(radius: showNewTaskView ? 8 : 0, opaque: false)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 0.5))
                    
                    
                    
                    //MARK: NEW TASK ITEM
                    
                    if showNewTaskView {
                        BlankView(
                            backgroundColor: isDarkMode ? Color.black : Color.gray,
                            backgroundOppacity: isDarkMode ?  0.3: 0.5
                        )
                            .onTapGesture{
                                withAnimation(){
                                    showNewTaskView = false
                                }
                            }
                        NewTaskItemView(isShowing: $showNewTaskView)
                    }
                
                }//: ZSTACK
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
                .navigationBarTitle("Daily Task", displayMode: .large)
                .navigationBarHidden(true)
                .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskView ? 8: 0, opaque: false)
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
            }//:  NAVIGATION
            .navigationViewStyle(StackNavigationViewStyle())
        }
    



  //MARK: PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
 }
}
