import UIKit

class TaskEditViewController: UIViewController
{
    @IBOutlet var titleInput : UITextField!
    @IBOutlet var memoInput : UITextView!
    
    var taskDidAdd: ((Task) -> Void)?
    
    @IBAction func cancelButtonDidTap()
    {
        
        let alertController = UIAlertController(
            title: "헉!",
            message: "진짜 취소 할거임??",
            preferredStyle: .alert
        )
        let yes = UIAlertAction(title: "작성하던거 날리기", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let no = UIAlertAction(title: "그대로 냅두기", style: .default, handler: nil)
        alertController.addAction(yes)
        alertController.addAction(no)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func DoneButtonDidTab()
    {
        guard let title = titleInput.text, !title.isEmpty else {
            self.shake(self.titleInput)
            return
        }
        let newTesk = Task(title: title)
        self.taskDidAdd?(newTesk)
        self.dismiss(animated: true, completion: nil)
    }
    
    func shake(_ view: UIView) {
        UIView.animate(
            withDuration: 0.05,
            animations: { view.frame.origin.x -= 5 },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.05,
                    animations: { view.frame.origin.x += 10 },
                    completion: { _ in
                        UIView.animate(
                            withDuration: 0.05,
                            animations: { view.frame.origin.x -= 10 },
                            completion: { _ in
                                UIView.animate(
                                    withDuration: 0.05,
                                    animations: { view.frame.origin.x += 10 },
                                    completion: { _ in
                                        UIView.animate(
                                            withDuration: 0.05,
                                            animations: { view.frame.origin.x -= 5 },
                                            completion: { _ in
                                                view.becomeFirstResponder()
                                        }
                                        )
                                }
                                )
                        }
                        )
                }
                )
        }
        )
    }
}
