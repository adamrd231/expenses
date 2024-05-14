//
//  PersistenceController.swift
//  Simple Budget
//
//  Created by Adam Reed on 5/8/24.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let container: NSPersistentContainer
    private let budgetEntity = "BudgetEntity"
    private let transactionEntity = "TransactionEntity"
    @Published var transactions: [TransactionEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Budgets")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                print("CoreData Error: \(error)")
            }
        })
    }
    
    func getTransactions() {
        let request = NSFetchRequest<TransactionEntity>(entityName: transactionEntity)
        do {
            transactions = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching transaction coredata: \(error)")
        }
    }
    
    func addNewTransaction(transaction: Transaction) {
        let newTransaction = TransactionEntity(context: container.viewContext)
        newTransaction.id = transaction.id
        newTransaction.amount = transaction.amount
        newTransaction.category = transaction.category.description
        newTransaction.date = transaction.date
        newTransaction.details = transaction.description
        newTransaction.type = transaction.type.name
        
    }
    
    func deleteCartItem(transaction: Transaction) {
        if let coreDataItem = transactions.first(where: { $0.id == transaction.id }) {
            container.viewContext.delete(coreDataItem)
        }
    }
    
    private func save() {
        do {
            print("SAVING VIEW CONTEXT")
            try container.viewContext.save()
            
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

    func applyChanges() {
        save()
        getTransactions()
    }
}


