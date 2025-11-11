import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"]

  show() {
    const input = this.inputTarget
    const output = this.outputTarget
    const file = input.files[0]

    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        output.src = e.target.result
        output.classList.remove("hidden")
      }
      reader.readAsDataURL(file)
    } else {
      output.src = ""
      output.classList.add("hidden")
    }
  }
}
