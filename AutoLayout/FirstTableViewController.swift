//
//  firstTableViewController.swift
//  AutoLayout
//
//  Created by JohnLui on 15/3/23.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class firstTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "firstTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "firstTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("firstTableViewCell", forIndexPath: indexPath) as firstTableViewCell

        cell.firstLabel.text = indexPath.row.description

        return cell
    }
}
