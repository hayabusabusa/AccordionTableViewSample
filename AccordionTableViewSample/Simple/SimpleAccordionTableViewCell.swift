//
//  SimpleAccordionTableViewCell.swift
//  AccordionTableViewSample
//
//  Created by Yamada Shunya on 2019/06/17.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class SimpleAccordionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentLabel: UILabel!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var childLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Required
        childView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(pText: String, cText: String, isOpen: Bool) {
        parentLabel.text = pText
        childLabel.text = cText
        
        // Required
        childView.isHidden = !isOpen
        childView.alpha = isOpen ? 1 : 0
    }
    
    func updateCell(isOpen: Bool) {
        if isOpen {
            open()
        } else {
            close()
        }
    }
    
    // 開くアニメーション: 開く -> アルファ値
    private func open() {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.childView.isHidden = false
        })
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       options: .curveEaseOut,
                       animations: {
                        self.childView.alpha = 1
        })
    }
    
    // 閉じるアニメーション: アルファ値 -> 閉じる
    private func close() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.childView.alpha = 0
        })
        
        // tableView.beginUpdate() のアニメーションと合わせるため0.3以上
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.childView.isHidden = true
        })
    }
}
