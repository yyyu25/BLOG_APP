import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame"]
  static values = { src: String }

  toggle() {
    const frame = this.frameTarget
    const isHidden = frame.style.display === "none" || frame.style.display === ""

    if (isHidden) {
      const url = this.srcValue + (this.srcValue.includes("?") ? "&" : "?") + "_ts=" + Date.now()
      frame.src = url
      frame.style.display = "block"
    } else {

      frame.style.display = "none"
      frame.removeAttribute("src")
      frame.innerHTML = ""
    }
  }
}
