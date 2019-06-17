//
//  SimpleViewController.swift
//  AccordionTableViewSample
//
//  Created by Yamada Shunya on 2019/06/17.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private struct Item {
        var title: String
        var desc: String
        var isOpen: Bool
    }
    
    private var items: [Item] = [
        Item(title: "タイトル", desc: "説明", isOpen: false),
        Item(title: "タイトル", desc: "You can regulate the height by either implementing the (a)heightForRowAtIndexPath with logic setting the heights or (b)with auto layout and automatic tableview row height", isOpen: false),
        Item(title: "[WindowServer]\ndisplay_timer_callback:\n unexpected state \n(now:19a601f4a779\n < expected:19a602e901d0)", desc: "You can regulate the height by either implementing the (a)heightForRowAtIndexPath with logic setting the heights or (b)with auto layout and automatic tableview row height\nYou can regulate the height by either implementing the (a)heightForRowAtIndexPath with logic setting the heights or (b)with auto layout and automatic tableview row height", isOpen: false),
        Item(title: "タイトル", desc: "workIntervalStart: startTimestamp > targetTimestamp; rolling forward by 0.316667", isOpen: true),
        Item(title: "タイトル", desc: "workIntervalStart: startTimestamp > targetTimestamp; rolling forward by 0.316667", isOpen: false),
        Item(title: "タイトル", desc: "workIntervalStart: startTimestamp > targetTimestamp; rolling forward by 0.316667", isOpen: false),
        Item(title: "タイトル", desc: "[WindowServer]\ndisplay_timer_callback:\n unexpected state \n(now:19a601f4a779\n < expected:19a602e901d0)", isOpen: false),
        Item(title: "タイトル", desc: "workIntervalStart: startTimestamp > targetTimestamp; rolling forward by 0.316667", isOpen: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SimpleViewController {
    
    func setupUI() {
        // Navigation
        navigationItem.title = "Simple"
        
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AccordionTableViewCell", bundle: nil), forCellReuseIdentifier: "AccordionTableViewCell")
    }
}

extension SimpleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccordionTableViewCell", for: indexPath) as! AccordionTableViewCell

        // Cell のセットアップ
        let item = items[indexPath.row]
        cell.setupCell(pText: item.title, cText: item.desc, isOpen: item.isOpen)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        // 開閉状態を切り替え
        items[indexPath.row].isOpen.toggle()

        // セルの高さが変わるため tableView.beginUpdates() ~ endUpdates()
        if let cell = tableView.cellForRow(at: indexPath) as? AccordionTableViewCell {
            tableView.beginUpdates()

            // タップしたセルを開ける
            cell.updateCell(isOpen: items[indexPath.row].isOpen)

            tableView.endUpdates()
        }
    }
}
