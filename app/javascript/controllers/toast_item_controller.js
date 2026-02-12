import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    duration: { type: Number, default: 5000 }
  }

  connect() {
    // Auto-remove timer
    this.timeout = setTimeout(() => {
      this.close()
    }, this.durationValue)
  }

  close() {
    // Clear timeout if exists
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    
    // Animation out
    this.element.classList.remove('opacity-100', 'translate-y-0')
    this.element.classList.add('opacity-0', 'translate-y-2')
    
    // Remove element after animation
    setTimeout(() => {
      if (this.element.parentNode) {
        this.element.parentNode.removeChild(this.element)
      }
    }, 300)
  }
}