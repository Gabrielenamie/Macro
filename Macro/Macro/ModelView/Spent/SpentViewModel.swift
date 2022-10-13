//
//  SpentsModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class SpentViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    @Published var spent : Spent
    
    init(spent: Spent) {
        self.spent = spent
    }

    func createSpent(categoryPercent: String) -> Spent? {
        if spent.title.isEmpty {
            return nil
        }
        if spent.icon.isEmpty {
            return nil
        }
        if spent.value.isZero {
            return nil
        }
        return spent
    }
    
    func postSpent(categoryPercent: String) {
        Task.init {
            guard let spent = createSpent( categoryPercent: categoryPercent ) else { return }
            try? await cloud.post(recordType: Spent.getType(), model: spent)
        }
    }
    
    func deleteSpent(spent: Spent) {
        Task.init {
            await cloud.delete(model: spent)
        }
    }
    
    func editSpent(spent: Spent) {
        Task.init {
            do {
                try await cloud.update(model: spent)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
