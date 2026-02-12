import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay"]
  
  connect() {
    console.log("Modal controller connected")
  }
  
  open(event) {
    event.preventDefault()
    
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      this.modalTarget.classList.add("flex")
    }
    
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.remove("hidden")
    }
  }
  
  close() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
      this.modalTarget.classList.remove("flex")
    }
    
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.add("hidden")
    }
  }
  
  closeOnEscape(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
  
  closeOnClickOutside(event) {
    if (event.target === this.element) {
      this.close()
    }
  }
}