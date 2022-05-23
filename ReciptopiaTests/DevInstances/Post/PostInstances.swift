//
//  PostInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation
import RxSwift
@testable import Reciptopia

extension DevInstances {
    
    class FakePostDataStore: PostDataStoreProtocol {
        
        // MARK: - Properties
        var fakePosts = [Post]()
        let isSucceedCase: Bool
        
        // MARK: - Methods
        init(isSucceedCase: Bool = true) {
            self.isSucceedCase = isSucceedCase
            for i in 1...Int.random(in: 2...20) {
                fakePosts.append(DevInstances.shared.generateRandomPost(id: i))
            }
        }
        
        func fetch(_ dto: PostDTO.Search) -> Observable<[Post]> {
            if !isSucceedCase {
                return Observable.error(ReciptopiaError.unknown)
            } else {
                return Observable.create { [weak self] observer in
                    guard let self = self else {
                        observer.onError(ReciptopiaError.unknown)
                        return Disposables.create()
                    }
                    observer.onNext(self.fakePosts)
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            }
        }
        
        func save(_ post: Post) -> Observable<Post> {
            if !isSucceedCase {
                return Observable.error(ReciptopiaError.unknown)
            } else {
                return Observable.create { observer in
                    observer.onNext(post)
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            }
        }
        
        func update(_ post: Post) -> Observable<Post> {
            if !isSucceedCase {
                return Observable.error(ReciptopiaError.unknown)
            } else {
                return Observable.create { observer in
                    observer.onNext(post)
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            }
        }
        
        func delete(_ post: Post) -> Observable<Void> {
            if !isSucceedCase {
                return Observable.error(ReciptopiaError.unknown)
            } else {
                return Observable.create { observer in
                    observer.onNext(())
                    observer.onCompleted()
                    
                    return Disposables.create()
                }
            }
        }
    }
}
