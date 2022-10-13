//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    @Binding var spent: Spent
    @StateObject var viewModel: SpentViewModel

    var body: some View {
        HStack {
            ZStack {
                Color(EnumColors.essenciaisColor.rawValue)
                    .cornerRadius(10)
                Image(systemName: "car.fill")
                    .foregroundColor(.white)
            }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9)
            VStack(alignment: .leading) {
                Text("Roda carro")
                    .font(.custom(EnumFonts.medium.rawValue, size: 17))
                Text("25/09/2021")
                    .font(.custom(EnumFonts.light.rawValue, size: 13))
            }.padding(.leading, 4)
            Spacer()
            Text("R$199,99")
                .font(.custom(EnumFonts.medium.rawValue, size: 20))
                .padding(.vertical)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false ) {
            Button {
                viewModel.deleteSpent(spent: spent)
            } label: {
                Label("Deletar", systemImage: "trash.fill")
            }
        }
        .swipeActions(edge: .leading) {
            NavigationLink {
                FormsSpentsView(viewModel: viewModel)
            } label: {
                Label("Editar", systemImage: "square.and.pencil")
            }
        }
    }
}

struct SpentsDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsDetailsCardView(spent: .constant(Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work)), viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))
    }
}
