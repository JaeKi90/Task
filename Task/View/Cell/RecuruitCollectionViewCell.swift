//
//  File.swift
//  Task
//
//  Created by trost.jk on 2022/09/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class RecuruitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    @IBOutlet weak var appealCollectionView: UICollectionView!
    
    @IBOutlet weak var rewordLabel: UILabel!
    
    var isBookmarked: Bool = false {
        didSet {
            if isBookmarked {
                self.testView.backgroundColor = .green
            } else {
                self.testView.backgroundColor = .red
            }
        }
    }
    
    var isRxOpen = false
    
    let testView = UIView().then {
        $0.backgroundColor = .red
    }
    
    static let defaultReuseIdentifier = "RecuruitCollectionViewCell"
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    fileprivate func cofigureCollectionView() {
        self.appealCollectionView.delegate = self
        self.appealCollectionView.dataSource = self
        self.appealCollectionView.collectionViewLayout = LeftAlignedCollectionViewFlowLayoutForHashTag()
        
        let nib = UINib.init(nibName: AppealTagCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        self.appealCollectionView.register(nib, forCellWithReuseIdentifier: AppealTagCollectionViewCell.defaultReuseIdentifier)
    }
    
    var appealTags = [String]()
    
    func render(recruitItem: RecruitItem, bookMarkRelay: PublishRelay<Int>?, isNeedBookmark: Bool) {
        self.backgroundColor = .white
        
        self.bookmarkButton.setTitle("", for: .normal)
        
        //image
        self.thumbNailImageView.layer.cornerRadius = 8
        self.thumbNailImageView.tintColor = .lightGray.withAlphaComponent(0.5)
        self.thumbNailImageView.setImage(
            with: recruitItem.imageURL,
            placeholder: UIImage(systemName: "circle.dashed")) { [weak self] result in
                guard let image = try? result.get().image else { return }
                self?.thumbNailImageView.image = image
            }
        
        //title
        self.titleLabel.text = recruitItem.title
        //rating
        self.pointLabel.text = "\(recruitItem.company.ratings[0].rating)"
        self.companyLabel.text = recruitItem.company.name
        //reword
        var rewordString = ""
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let rewordNumberString = numberFormatter.string(from: NSNumber(value: recruitItem.reward)) {
            rewordString = rewordNumberString
        }
        self.rewordLabel.text = "축하금: \(rewordString)"
        
        if recruitItem.appeal != "" {
            self.appealTags = recruitItem.appeal.components(separatedBy: ", ")
        }

        if appealTags.count > 0 {
            self.appealCollectionView.isHidden = false
            self.cofigureCollectionView()
            self.appealCollectionView.reloadData()
        } else {
            self.appealCollectionView.isHidden = true
        }
        
        if isNeedBookmark {
            if recruitItem.isBookmark {
//                print("==== 셀에서 에서 북마크 선택 표시 \(recruitItem.id): \(recruitItem.title)")
                self.bookmarkButton.imageView?.image = UIImage(named: "icon_bookmark")
                self.isBookmarked = true
            } else {
//                print("==== 셀에서 에서 북마크 선택 해제 \(recruitItem.id): \(recruitItem.title)")
                self.bookmarkButton.imageView?.image = UIImage(named: "icon_bookmark_off")
                self.isBookmarked = false
            }
        } else {
            self.bookmarkButton.isHidden = true
        }
        
        //rx
        if !isRxOpen {
            self.bookmarkButton.rx.throttleTap
                .withUnretained(self)
                .subscribe { _ in
                    bookMarkRelay?.accept(recruitItem.id)
                    print("==== 셀 에서 북마크 선택  \(recruitItem.id): \(recruitItem.title )")
                }.disposed(by: self.disposeBag)
            
            self.isRxOpen = true
        }
        
    }
    
}

extension RecuruitCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appealCollectionView.dequeueReusableCell(
            withReuseIdentifier: AppealTagCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as! AppealTagCollectionViewCell
        
        cell.tagTitle.text = self.appealTags[indexPath.row]
        
        return cell
    }
    
}

extension RecuruitCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textContent = self.appealTags[indexPath.row]
        let textContentSize = textContent.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)
        ])
        let padding = CGFloat(12)
        
        return CGSize(width: textContentSize.width + padding, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
