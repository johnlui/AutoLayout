//
//  firstTableViewController.swift
//  AutoLayout
//
//  Created by JohnLui on 15/3/23.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class firstTableViewController: UITableViewController {
    
    var labelArray = Array<String>() // 用于存储 label 文字内容
    
    var prototypeCell: firstTableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "firstTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "firstTableViewCell")
        
        // 初始化 prototypeCell 以便复用
        prototypeCell = tableView.dequeueReusableCellWithIdentifier("firstTableViewCell") as! firstTableViewCell
        
        // 循环生成 label 文字内容
        for i in 1...10 {
            var text = ""
            for j in 1...i {
                text += "Auto Layout "
            }
            labelArray.append(text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = prototypeCell
        cell.firstLabel.text = labelArray[indexPath.row]
        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("firstTableViewCell", forIndexPath: indexPath) as! firstTableViewCell

        cell.firstLabel.text = labelArray[indexPath.row]
        
        if indexPath.row < 3 {
            var image = UIImage(named: indexPath.row.description)!
            if image.size.width > 80 {
                image = image.resizeToSize(CGSizeMake(80, image.size.height * (80 / image.size.width)))
            }
            cell.logoImageView.image = image
        }

        return cell
    }
}
