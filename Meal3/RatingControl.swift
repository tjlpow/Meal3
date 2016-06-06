//
//  RatingControl2.swift
//  Meal3
//
//  Created by baidu on 16/5/22.
//  Copyright © 2016年 baidu. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    //MARK: Properties
    
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButton = [UIButton]()
    let starCount = 5
    let spacing = 5
    
    //MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let buttonSize = Int(frame.size.height)
        let emptyStar = UIImage(named: "emptyStar")
        let filledStar = UIImage(named: "filledStar")
        
        for _ in 0..<starCount {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(filledStar, forState: [.Highlighted, .Selected])

            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents:.TouchDown)
            
            ratingButton += [button]
        
            addSubview(button)
        }
        
        
        
    }
    
    //Layout the buttons
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButton.enumerate() {
            
            buttonFrame.origin.x = CGFloat((buttonSize + spacing) * index)
            button.frame = buttonFrame
            
        }
        
        updateButtonSelectionState()
        
    }
    
    //Define the size of the custom view
    
    override func intrinsicContentSize() -> CGSize {
        
        let buttonSize = Int(frame.size.height)
        
        return CGSize(width: starCount * buttonSize + (starCount-1) * spacing, height: buttonSize)
    }
    
    //MARK: Action
    
    func ratingButtonTapped(button:UIButton) {
        
        rating = ratingButton.indexOf(button)! + 1
        
        updateButtonSelectionState()
    
    }

    func updateButtonSelectionState() {
        
        for (index, button) in ratingButton.enumerate() {
            
            button.selected = index < rating
        }
    }
}
