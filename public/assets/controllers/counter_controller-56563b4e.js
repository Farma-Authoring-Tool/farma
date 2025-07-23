import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["output"]

    increment() {
        this.outputTarget.textContent = parseInt(this.outputTarget.textContent) + 1
    }
}
