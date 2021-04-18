//
//  MasterTableViewController.swift
//  CatalogoSnippets
//
//  Created by Jemesson Lima on 18/04/21.
//

import UIKit

protocol SnippetSelectionDelegate: AnyObject {
    func snippetSelected(_ newSnippet: Snippet)
}

class MasterTableViewController: UITableViewController {
    @IBOutlet weak var btAddSnippet: UIBarButtonItem!
    weak var delegate: SnippetSelectionDelegate?
    var tfName: UITextField!

    var snippets: [Snippet] = [
        Snippet(name: "Snippet 1", content: "let x = 10", tag: "Networking"),
        Snippet(name: "Snippet 2", content: "let y = true", tag: "Persistência"),
        Snippet(name: "Snippet 3", content: "let z = \"abc\"", tag: "Layouts")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewSnippet(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Snippet", message: "Add a snippet to the list", preferredStyle: .alert)

            alert.addTextField { (tfName) in
            self.tfName = tfName
            self.tfName.autocapitalizationType = .words
            self.tfName.placeholder = "eg: My Snippet"
        }
        
        // Add cancel button to alert controller
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add button with callback
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            if let name = self.tfName.text, name != "" {
                self.snippets.append(contentsOf: [Snippet(name: self.tfName.text ?? "New Snippet", content: "", tag: "")])
                self.tableView.reloadData()
            }
        }))

        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = snippets[indexPath.row].name

        return cell
        
    }

    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        snippets.count
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets[indexPath.row]
        delegate?.snippetSelected(selectedSnippet)

        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.show(detailViewController, sender: nil)
        }
    }
}
