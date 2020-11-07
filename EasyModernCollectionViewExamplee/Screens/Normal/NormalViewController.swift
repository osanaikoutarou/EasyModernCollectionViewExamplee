//
//  NormalViewController.swift
//  EasyModernCollectionViewExamplee
//
//  Created by 長内幸太郎 on 2020/11/07.
//

import UIKit

class NormalViewController: UIViewController {
    /// Section1に表示するデータ
    class Model1 {
    }
    /// Section2に表示するデータ
    class Model2 {
    }
    /// Section3に表示するデータ
    class Model3 {
    }
    /// Section4に表示するデータ
    class Model4 {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case first   // 1個のCell
        case second  // 横スクロール
        case thiard  // 横3列,縦2列
        case fourth  // 縦スクロール（無限）
    }
    
    // 表示するSectionのリストを定義する
    var sections: [Section] = [.first, .second, .thiard, .fourth]
    
    var datas1: Model1 = Model1()
    var datas2: [Model2] = [Model2](repeating: Model2(), count: 20)
    var datas3: [Model3] = [Model3](repeating: Model3(), count: 6)
    var datas4: [Model4] = [Model4](repeating: Model4(), count: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension NormalViewController: UICollectionViewDataSource {
    /// セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    /// セクション内セル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // セクションのタイプを得る
        let section = sections[section]
        
        switch section {
        case .first:
            return 1
        case .second:
            return datas2.count
        case .thiard:
            return datas3.count
        case .fourth:
            return datas4.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セクションのタイプを得る
        let section = sections[indexPath.section]
        
        switch section {
        case .first:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
            return cell
        case .second:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
            return cell
        case .thiard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
            return cell
        case .fourth:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionViewCell", for: indexPath) as! FourthCollectionViewCell
            return cell
        }
    }
    
    
}
