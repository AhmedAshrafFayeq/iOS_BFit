//
//  ExerciseImageCollectionViewCell.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import UIKit
import SDWebImage

class ExerciseImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Vars
    static let identifier = "ExerciseImageCollectionViewCell"
    
    private let exerciseImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "heart")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    //MARK: - Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupLayouts()
        ConfigureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    //MARK:- Layouts / Constraints
    private func setupLayouts(){
        contentView.addSubview(exerciseImageView)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func ConfigureConstraints(){
        exerciseImageView.frame = contentView.bounds
    }
    
    //MARK:- Cell Configuration with Models
    public func configureCell(image: String) {
        
        if let url = URL(string: image) {
//            imgView.sd_setShowActivityIndicatorView(true)
//            imgView.sd_setIndicatorStyle(.gray)
            self.exerciseImageView.sd_setImage(with: url, completed: nil)
        }else {
            self.exerciseImageView.image = UIImage(named: "placeholder")
        }
        
    }
    
}
