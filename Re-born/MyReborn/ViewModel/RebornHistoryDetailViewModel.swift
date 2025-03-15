//
//  RebornHistoryDetailViewModel.swift
//  Re-born
//
//  Created by jaegu park on 3/15/25.
//

import Combine
import CoreData

class RebornHistoryDetailViewModel {
    private var cancellables = Set<AnyCancellable>()
    private let container: NSPersistentContainer
    
    @Published var timeSecond: Int = 10
    private var timer: AnyCancellable?
    
    init(container: NSPersistentContainer) {
        self.container = container
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchContact()
            }
    }
    
    private func fetchContact() {
        do {
            let contact = try self.container.viewContext.fetch(Entity.fetchRequest())
            if let firstContact = contact.first {
                self.timeSecond = Int(firstContact.seconds)
            }
        } catch {
            print("Failed to fetch contact: \(error.localizedDescription)")
        }
    }
}
