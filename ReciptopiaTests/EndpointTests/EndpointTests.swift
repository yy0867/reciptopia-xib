//
//  EndpointTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/23.
//

import XCTest
@testable import Reciptopia

class EndpointTests: XCTestCase {
    
    func test_Paging_asQuery_shouldReturnExpectedURLQueryItem() {
        // Given
        let expectedPage = Int.random(in: 1...20)
        let expectedSize = Int.random(in: 1...20)
        let paging = Paging(page: expectedPage, size: expectedSize)
        
        
        // When
        let queries = paging.asQuery()
        let page = queries.first
        let size = queries.last
        
        // Then
        XCTAssertNotNil(page)
        XCTAssertNotNil(size)
        
        XCTAssertEqual("page", page?.name)
        XCTAssertEqual("\(expectedPage)", page?.value)
        
        XCTAssertEqual("size", size?.name)
        XCTAssertEqual("\(expectedSize)", size?.value)
    }
    
    func test_Sorting_asQuery_shouldReturnExpectedURLQueryItem() {
        for property in Sorting.Property.allCases {
            for order in Sorting.Order.allCases {
                // Given
                let sorting = Sorting(property: property, order: order)
                
                // When
                let query = sorting.asQuery().first
                
                // Then
                XCTAssertNotNil(query)
                XCTAssertEqual("sort", query?.name)
                XCTAssertEqual("\(property.rawValue),\(order.rawValue)", query?.value)
            }
        }
    }
}
