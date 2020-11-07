//
//  ModernViewController.swift
//  EasyModernCollectionViewExamplee
//
//  Created by 長内幸太郎 on 2020/11/07.
//

import UIKit

class ModernViewController: UIViewController {
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
        case thiard  // 横3列,縦2行
        case fourth  // 縦スクロール（無限）
    }
    
    // 表示するSectionのリストを定義する
    var sections: [Section] = [.first, .second, .thiard, .fourth]
    
    var datas1: Model1 = Model1()
    var datas2: [Model2] = [Model2](repeating: Model2(), count: 20)
    var datas3: [Model3] = [Model3](repeating: Model3(), count: 5)
    var datas4: [Model4] = [Model4](repeating: Model4(), count: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    
}

extension ModernViewController: UICollectionViewDataSource {
    /// セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    /// セクション内セル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // セクションのタイプを得る
        let sectionType = sections[section]
        
        switch sectionType {
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
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .first:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
            cell.label.text = "First-\(indexPath.item)"
            return cell
        case .second:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
            cell.label.text = "Second-\(indexPath.item)"
            return cell
        case .thiard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
            cell.label.text = "Third-\(indexPath.item)"
            return cell
        case .fourth:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionViewCell", for: indexPath) as! FourthCollectionViewCell
            cell.label.text = "Fourth-\(indexPath.item)"
            return cell
        }
    }
}

extension ModernViewController {
    /// ここが新しい要素
    func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionType = self.sections[sectionIndex]
            
            // ① cellのsizeを決める
            // ② layoutItemを作成する
            //    layoutItem(cell)のcontentInsetを決める（任意）
            // ③ groupのsizeを決める
            // ④ layoutItemからlayoutGroupを作る（様々な形式がある）
            //    layoutGroupのcontentInsetを決める（任意）
            // ⑤ layoutGroupからlayoutSectionを作る
            //    layoutSectionのcontentInsetを設定する（任意）
            //    layoutSection内のスペースを設定する（任意）
            //    layoutSection内でページングするかどうかを設定する（任意）
            //    layoutSectionを横スクロールにする（任意）
            // ⑥ return layoutSection
            
            switch sectionType {
            case .first:    // 1個のCell
                // ①
                let cellSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),    // 横幅いっぱい
                                                      heightDimension: .absolute(100.0))        // 固定100.0
                // ②
                 let item = NSCollectionLayoutItem(layoutSize: cellSize)
                // ③
                let groupSize = cellSize    // cell1個だから全く同じ
                // ④
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 横
                // ⑤
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                return layoutSection
                
            case .second:   // 横スクロール
                // ①
                let cellSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), // グループに対して横いっぱい
                                                      heightDimension: .absolute(60.0)) // 固定60.0
                // ②
                let item = NSCollectionLayoutItem(layoutSize: cellSize)
                item.contentInsets = .zero
                // ③
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),   // 横幅の30％
                                                       heightDimension: .absolute(60.0))        // 固定60.0
                // ④
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])   // 横, 1Group1Cell
                // ⑤
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                // 横スクロールにする
                layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                layoutSection.interGroupSpacing = 10
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return layoutSection
            case .thiard:   // 上が横3列,下が横2列
                // 上①
                let cellSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0), // groupに対し1/3
                                                       heightDimension: .fractionalHeight(1.0))   // groupに対していっぱい
                // 上②
                let item1 = NSCollectionLayoutItem(layoutSize: cellSize1)
                // 上③
                let groupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),   // 親groupに対していっぱい
                                                        heightDimension: .absolute(60.0))         // 固定60.0
                // 上④
                let layoutGroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize1,
                                                                      subitem: item1, count: 2)
                layoutGroup1.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
                // 下①
                let cellSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), // groupに対し1/2
                                                       heightDimension: .fractionalHeight(1.0))   // groupに対していっぱい
                // 下②
                let item2 = NSCollectionLayoutItem(layoutSize: cellSize2)
                // 下③
                let groupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),   // 親groupに対していっぱい
                                                        heightDimension: .absolute(60.0))         // 固定60.0
                // 下④
                let layoutGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize2,
                                                                      subitem: item2, count: 3)
                layoutGroup2.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
                
                // groupのgroup③
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),   // 画面に対していっぱい
                                                       heightDimension: .absolute(122.0))       // 固定120.0
                // groupのgroup④
                let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                   subitems: [layoutGroup1, layoutGroup2])
                layoutGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
                
                // ⑤
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                return layoutSection
            case .fourth:   // 縦スクロール（無限）
                // ①
                let cellSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/4.0), // groupに対して1/4
                                                      heightDimension: .fractionalHeight(1.0))   // groupに対していっぱい
                // ②
                let item = NSCollectionLayoutItem(layoutSize: cellSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                // ③
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),           // 画面に対していっぱい
                                                       heightDimension: .fractionalWidth(1.6/4.0))      // 画面横に対して1.6倍
                // ④
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                // ⑤
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                return layoutSection
            }
        }
    }
}
