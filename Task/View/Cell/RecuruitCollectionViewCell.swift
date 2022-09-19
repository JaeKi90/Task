//
//  File.swift
//  Task
//
//  Created by trost.jk on 2022/09/17.
//

import UIKit
import RxSwift
import RxCocoa

class RecuruitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    @IBOutlet weak var appealCollectionView: UICollectionView!
    
    @IBOutlet weak var rewordLabel: UILabel!
    
    static let defaultReuseIdentifier = "RecuruitCollectionViewCell"
    static let defaultReuseIdentifier2 = "RecuruitCollectionViewCell2"
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        self.disposeBag = DisposeBag()
    }
    
    fileprivate func cofigureCollectionView() {
        self.appealCollectionView.delegate = self
        self.appealCollectionView.dataSource = self
        self.appealCollectionView.collectionViewLayout = LeftAlignedCollectionViewFlowLayoutForHashTag()
        
        let nib = UINib.init(nibName: AppealTagCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        self.appealCollectionView.register(nib, forCellWithReuseIdentifier: AppealTagCollectionViewCell.defaultReuseIdentifier)
    }
    
    var appealTags = [String]()
    
    func render(recruitItem: RecruitItem, bookMarkRelay: PublishRelay<Int>?) {
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
        
        if recruitItem.isBookmark {
            self.bookmarkButton.imageView?.image = UIImage(named: "icon_bookmark")
//            self.bookmarkButton.isHidden = true
        } else {
            self.bookmarkButton.imageView?.image = UIImage(named: "icon_bookmark_off")
        }
        
        //rx
        if let bookMarkRelay = bookMarkRelay {
            self.bookmarkButton.rx.throttleTap
                .subscribe { _ in
                    bookMarkRelay.accept(recruitItem.id)
                }.disposed(by: disposeBag)
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
