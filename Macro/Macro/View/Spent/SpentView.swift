//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    @Binding var title: String
    @Binding var spends: [Spent]
    var body: some View {
            VStack(alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                    .padding(.leading)
                Text("R$ 1470,00")
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    .padding(.leading)
                Text("Limite disponivel R$ 530,00")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .padding(.leading)
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink(destination: FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            List {
                ForEach($spends) { spent in
                    SpentsDetailsCardView(spent: spent, viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))
                }
//                SpentsDetailsCardView(spent: Spent(title: "Carro", value: 33.0, icon: "carro", date: Date(), categoryPercent: EnumCategoryPercent.work), viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))
            } .listStyle(.insetGrouped)
        }
        .navigationTitle(title)
        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))
    }
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpentView(title: .constant("tá de palhaçada"), spends: .constant([Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work)]))
        }
    }
}
