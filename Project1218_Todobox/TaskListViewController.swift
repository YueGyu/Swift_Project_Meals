//
//  TaskListViewController.swift
//  Project1218_Todobox
//
//  Created by 조여규 on 18/12/2016.
//  Copyright © 2016 조여규. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAll()
        self.tableView.reloadData()
    }
    
    func saveAll() {
        let dicts = self.tasks.map { task -> [String: Any] in
            return [
                "title": task.title,
                "done": task.done,
            ]
            if let memo = task.memo {
                dicts["memo"] = memo
            }
            return dicts
        }
        UserDefaults.standard.set(dicts, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    func loadAll() {
        guard let dicts = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]]
            else { return }
        self.tasks = dicts.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
            let rootViewController = navigationController.viewControllers.first,
            let taskEditViewController = rootViewController as? TaskEditViewController {
            taskEditViewController.taskDidAdd = { newTask in
                self.tasks.append(newTask)
                self.saveAll()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.memo
        if task.done
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        var task = tasks[i]
        task.done = !task.done
        tasks[i] = task
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


