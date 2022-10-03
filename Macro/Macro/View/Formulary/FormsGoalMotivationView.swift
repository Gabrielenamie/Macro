//
//  MotivationView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalMotivationView: View {
    var goal: Goal
    var motivations: [String] = ["Guardar dinheiro", "Realização de um sonho", "Sempre quis conquistar essa meta"]
    @State var index = 0
    @State var motivation = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Qual a motivação?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Selecione qual motivação mais se encaixa na sua meta (opcional)")
                .padding(10)
            
            Button {
                index = 1
                motivation = motivations[index - 1]
            } label: {
                MotivationCard(text: motivations[0])
                    .foregroundColor(index == 1 ? Color("ButtonColor") : Color("ButtonUnselect"))
            }

            Button {
                index = 2
                motivation = motivations[index - 1]

            } label: {
                MotivationCard(text: motivations[1])
                    .foregroundColor(index == 2 ? Color("ButtonColor") : Color("ButtonUnselect"))
            }

            Button {
                index = 3
                motivation = motivations[index - 1]

            } label: {
                MotivationCard(text: motivations[2])
                    .foregroundColor(index == 3 ? Color("ButtonColor") : Color("ButtonUnselect"))
            }

            Spacer()
        }
        .padding(20)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    goal.motivation = motivation
                    Task.init {
                       try? await CloudKitModel.shared.post(recordType: Goal.getType(), model: goal)
                    }
                    print("saving...")
                } label: {
                    Text("Salvar")
                }

            }
        }
    }
}

struct MotivationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormsGoalMotivationView(goal: Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 1, crescent: true)))
        }
    }
}
