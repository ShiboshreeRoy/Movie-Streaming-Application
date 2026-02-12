import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "submit"]
  
  connect() {
    console.log("Rating controller connected")
  }
  
  submitRating(event) {
    event.preventDefault()
    
    const formData = new FormData(event.target)
    const rating = formData.get("rating")
    const movieId = formData.get("movie_id")
    
    // Make AJAX request to submit rating
    fetch("/user_movie_ratings", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        rating: rating,
        movie_id: movieId
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        // Update UI to reflect successful rating
        const ratingText = document.querySelector(".rating-display")
        if (ratingText) {
          ratingText.textContent = `Your rating: ${data.rating}/10`
        }
        alert(`Rating submitted successfully! You rated this movie ${data.rating}/10`)
      } else {
        alert("Error submitting rating: " + data.errors.join(", "))
      }
    })
    .catch(error => {
      console.error("Error:", error)
      alert("There was an error submitting your rating")
    })
  }
}