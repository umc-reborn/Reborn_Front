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
        let request: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            if let timerEntity = results.first {
                let totalSeconds = (Int(timerEntity.minutes) * 60) + Int(timerEntity.seconds)
                self.timeSecond = totalSeconds
            }
        } catch {
            print("⚠️ 타이머 데이터를 불러오지 못했습니다: \(error.localizedDescription)")
        }
    }
    
    private func saveTimerToCoreData() {
        let context = container.viewContext
        let request: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            let timerEntity: Entity
            
            let totalSeconds = self.timeSecond
            timerEntity.minutes = Int64(totalSeconds / 60) // ✅ 분 저장
            timerEntity.seconds = Int64(totalSeconds % 60)
            
            try context.save()
        } catch {
            print("⚠️ 타이머 데이터를 저장하지 못했습니다: \(error.localizedDescription)")
        }
    }
}
