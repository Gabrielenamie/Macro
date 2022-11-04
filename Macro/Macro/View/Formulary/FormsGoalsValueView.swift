//
//  FormsGoalsValueView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalsValueView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    
    @State var goal: Goal
    @Binding var popToRoot: Bool
    
    @State private var value: String = ""
    @FocusState var keyboardIsFocused: Bool
    @State var validTextField = false

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quanto você deseja guardar?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Depositando R$ 1 por semana de forma gradual, em 52 semanas você irá ter em sua conta R$ 1.378,00")
                .padding(10)
            TextField("Ex.: R$ 1.378,00", text: $value)
                .foregroundColor(.black)
                .keyboardType(.decimalPad)
                .focused($keyboardIsFocused)
                .underlineTextField()
                .padding(5)
                .onChange(of: value) { _ in
                    if let stringMoney = value.transformToMoney() {
                        value = stringMoney
                        goal.value = stringMoney.replacingOccurrences(of: ".", with: "").floatValue
                        validTextField = true
                    } else {
                        validTextField = false
                    }
                }
            PrioritySelector(priority: $goal.priority)
            Spacer()
            NavigationLink {
                FormsGoalMotivationView(goal: goal, popToRoot: $popToRoot)
            } label: {
                TemplateTextButton(text: EnumButtonText.nextButton.rawValue, isTextFieldEmpty: !isValidValue)
            }
            .isDetailLink(false)
            .disabled(!isValidValue)
        }
        .padding(20)
    }
}

// struct FormsGoalsValueView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsGoalsValueView(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 1, crescent: true))), popToRoot: .constant(true))
//    }
// }
