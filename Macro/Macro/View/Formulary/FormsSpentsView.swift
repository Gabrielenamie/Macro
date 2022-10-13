//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsSpentsView: View {
    @StateObject var viewModel: SpentViewModel
    @State private var showingSheet = false
    @State var selectedIcon: String = "car.fill"
    var colorIcon: String
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
            Form {
                Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: Luz", text: $viewModel.nameSpent)
                        .underlineTextField()
                        .listRowBackground(Color.clear)
                }.textCase(.none)
                
                Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    Button(">") {
                        showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet) {
                        ModalView(selectedIcon: $selectedIcon, colorIcon: colorIcon)
                    } .padding(.leading, UIScreen.screenWidth*0.77)
                    .listRowBackground(Color.clear)
                            .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: R$200,00", value: $viewModel.valueSpent, formatter: formatter)
                        .listRowBackground(Color.clear)
                        .keyboardType(.decimalPad)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    DatePicker("", selection: $viewModel.datePickerSpent, displayedComponents: [.date])
                            .listRowBackground(Color.clear)
                            .labelsHidden()
                }.textCase(.none)
            }.navigationBarTitle("Gastos", displayMode: .inline)
                .toolbar {
                    Button {
                        viewModel.postSpent()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Salvar")
                    }

                }
    }
}
extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(Color("LineColorForms"))
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work), colorIcon: EnumColors.essenciaisColor.rawValue)
//            FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work), popToView: .constant(false))
        }
    }
}
