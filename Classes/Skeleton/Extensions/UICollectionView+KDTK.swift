//
//  UICollectionView.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/7.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    enum WayToUpdate {
        
        case none
        case reloadData
        case insert([IndexPath])
        
        var needsLabor: Bool {
            
            switch self {
            case .none:
                return false
            case .reloadData:
                return true
            case .insert:
                return true
            }
        }
        
        func performWithCollectionView(_ collectionView: UICollectionView) {
            
            switch self {
                
            case .none:
                println("collectionView WayToUpdate: None")
                break
                
            case .reloadData:
                println("collectionView WayToUpdate: ReloadData")
                SafeDispatch.async {
                    collectionView.reloadData()
                }
                
            case .insert(let indexPaths):
                println("collectionView WayToUpdate: Insert")
                SafeDispatch.async {
                    collectionView.insertItems(at: indexPaths)
                }
            }
        }
    }
}

extension UICollectionView {
    
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        
        register(T.self, forCellWithReuseIdentifier: T.kdReuseIdentifier)
    }
    
    func registerNibOf<T: UICollectionViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.kdReuseIdentifier)
    }
    
    func registerHeaderNibOf<T: UICollectionReusableView>(_: T.Type) where T: Reusable, T: NibLoadable {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.kdReuseIdentifier)
    }
    
    func registerFooterClassOf<T: UICollectionReusableView>(_: T.Type) where T: Reusable {
        
        register(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: T.kdReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.kdReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.kdReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.kdReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.kdReuseIdentifier), kind: \(kind)")
        }
        
        return view
    }
}
