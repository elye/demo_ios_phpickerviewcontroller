import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var imagePicker: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        imagePicker.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changeImage() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        controller.mediaTypes = ["public.image"]
        present(controller, animated: true)
    }
    
    func didSelect(image: UIImage?) {
        self.imagePicker.image = image
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.didSelect(image: image)
    }
}

extension ViewController: UINavigationControllerDelegate {

}

