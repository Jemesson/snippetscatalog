//
//  DetailViewController.swift
//  CatalogoSnippets
//
//  Created by Jemesson Lima on 18/04/21.
//

import UIKit
import Sourceful

class DetailViewController: UIViewController {
    @IBOutlet weak var textView: SyntaxTextView!
    @IBOutlet weak var menuBar: UINavigationItem!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl!
    var selectedLanguage: String = "Swift"
    var snippet: Snippet? {
        didSet {
            refreshUI()
        }
    }
    var sourceCodeTheme: SourceCodeTheme {
        if UIApplication.activeTraitCollection.userInterfaceStyle == .dark {
            return DarkTheme()
        } else {
            return LightTheme()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.theme = sourceCodeTheme
        textView.delegate = self
        textView.contentTextView.inputAccessoryView = UIView.editingToolbar(
            target: self,
            action: #selector(addToTextView)
        )
    }

    @IBAction func selectLanguage(_ sender: UISegmentedControl) {
        let title = languageSegmentControl.titleForSegment(at: languageSegmentControl.selectedSegmentIndex)
        
        if(title! == "Swift"){
            selectedLanguage = "Swift"
        } else {
            selectedLanguage = "Python"
        }

        snippet?.content = textView.text
    }

    private func refreshUI() {
        loadViewIfNeeded()
        menuBar.title = snippet?.name ?? "Snippets"
        textView.text = snippet?.content ?? ""
    }

    @objc func addToTextView(_ sender: UIBarButtonItem) {
        guard let value = UnicodeScalar(sender.tag) else { return }
        textView.insertText(String(value))
        UIDevice.current.playInputClick()
    }
}

extension DetailViewController: SnippetSelectionDelegate {
    func snippetSelected(_ newSnippet: Snippet) {
        snippet = newSnippet
    }
}

extension DetailViewController: SyntaxTextViewDelegate {
    func lexerForSource(_ source: String) -> Lexer {
        if selectedLanguage == "Swift" {
            return SwiftLexer()
        }
        return Python3Lexer();
    }
}
