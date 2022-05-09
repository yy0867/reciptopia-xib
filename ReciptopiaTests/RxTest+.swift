//
//  RxTest+.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/09.
//

import RxTest
import RxSwift
import XCTest

extension XCTestCase {
    
    func makeRecordedEvents<Element>(
        by elements: [Element],
        from initialClock: TestTime = TestScheduler.Defaults.subscribed,
        to disposeTime: TestTime = TestScheduler.Defaults.disposed
    ) -> [Recorded<Event<Element>>] {
        let randomTimes = generateRandomTimes(
            count: elements.count,
            from: initialClock,
            to: disposeTime
        )
        
        var events = [Recorded<Event<Element>>]()
        
        for (index, time) in randomTimes.enumerated() {
            events.append(.next(time, elements[index]))
        }
        
        return events
    }
    
    private func generateRandomTimes(
        count: Int,
        from initialClock: TestTime,
        to disposeTime: TestTime
    ) -> [TestTime] {
        guard (initialClock + 10) < (disposeTime - 10) else { return [] }
        
        var sequence = Array((initialClock + 10)...(disposeTime - 10))
        if sequence.count < count { return [] }
        
        var randomTimes = [TestTime]()
        
        for _ in 1...count {
            let randomIndex = Int.random(in: 0..<sequence.count)
            randomTimes.append(sequence.remove(at: randomIndex))
        }
        
        return randomTimes.sorted()
    }
}
