import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "icon"]
  static values = { 
    movieId: Number,
    isFavorite: Boolean 
  }
  
  connect() {
    console.log("Favorite controller connected")
  }
  
  toggleFavorite(event) {
    event.preventDefault()
    
    if (this.isFavoriteValue) {
      // Remove from favorites
      this.removeFromFavorites()
    } else {
      // Add to favorites
      this.addToFavorites()
    }
  }
  
  addToFavorites() {
    fetch("/user_favorites", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        movie_id: this.movieIdValue
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        this.isFavoriteValue = true
        this.updateButton()
        alert("Added to favorites!")
      }
    })
    .catch(error => {
      console.error("Error:", error)
      alert("There was an error adding to favorites")
    })
  }
  
  removeFromFavorites() {
    // We need the favorite ID to delete, so we'll need to fetch it first
    // Or we can pass it in as a value
    fetch(`/user_favorites/${this.element.dataset.favoriteId}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        this.isFavoriteValue = false
        this.updateButton()
        alert("Removed from favorites!")
      }
    })
    .catch(error => {
      console.error("Error:", error)
      alert("There was an error removing from favorites")
    })
  }
  
  updateButton() {
    if (this.hasIconTarget) {
      this.iconTarget.textContent = this.isFavoriteValue ? "★" : "☆"
    }
    
    if (this.hasButtonTarget) {
      this.buttonTarget.className = this.isFavoriteValue 
        ? "bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded" 
        : "bg-gray-700 hover:bg-gray-600 text-white px-4 py-2 rounded"
      this.buttonTarget.textContent = this.isFavoriteValue ? "Unfavorite" : "Favorite"
    }
  }
}