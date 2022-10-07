//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var bool = false
    @State var goals = [Goal(title: "Carro Novo", value: 5000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))]
    @StateObject var vm = GoalCardViewModel()
    
    var viewCardSpends = [
        SpentsCardView(spentsCards: SpentsCards(id: 1, colorName: "PriorityColor", title: "Prioridades")),
        SpentsCardView(spentsCards: SpentsCards(id: 2, colorName: "PriorityColor", title: "Prioridades")),
        SpentsCardView(spentsCards: SpentsCards(id: 3, colorName: "PriorityColor", title: "Prioridades"))
    ]
    
    var body: some View {
        //NavigationView {
        VStack {
            HStack {
                Text("Nossas metas")
                    .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                    .padding()
                Spacer()
                Button(role: nil) {
                    print("add meta")
                } label: {
                    Label("", systemImage: "plus")
                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding(.bottom, 2)
                        .padding(.trailing)
                }
            } .padding(.top, 48)
            CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, goals: $goals)
            
            VStack(spacing: 0) {
                HStack {
                    Text("Nossos Gastos")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding([.top, .leading])
                    
                    Spacer()
                }
                ForEach(SpentsCards.spentsCards) { spends in
                    NavigationLink(destination: SpentView()) {
                        SpentsCardView(spentsCards: spends)
                            .padding()
                        
                    }
                }
            }
            
        }
        .background(Color(EnumColors.backgroundScreen.rawValue))
        .navigationTitle("Bom dia!")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .font(.custom(EnumFonts.bold.rawValue, size: 34))
        .toolbar {
            //                Button(role: nil) {
            //                    print("add configuração")
            //                } label: {
            //                    Label("", systemImage: "gearshape")
            //                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
            //                        .padding(.trailing)
            //                        .padding(.top)
            //                }
            
        }
    }
    //   }
    
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
