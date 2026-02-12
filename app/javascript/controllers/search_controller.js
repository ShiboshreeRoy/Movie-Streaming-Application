import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  
  connect() {
    console.log("Search controller connected")
  }
  
  search() {
    clearTimeout(this.searchTimeout)
    
    this.searchTimeout = setTimeout(() => {
      const query = this.inputTarget.value
      
      if (query.length > 2) {
        // Perform live search
        fetch(`/search?q=${encodeURIComponent(query)}`)
          .then(response => response.text())
          .then(html => {
            if (this.hasResultsTarget) {
              this.resultsTarget.innerHTML = html
            }
          })
      } else if (query.length === 0) {
        // Clear results when input is empty
        if (this.hasResultsTarget) {
          this.resultsTarget.innerHTML = ""
        }
      }
    }, 300) // Debounce search by 300ms
  }
}