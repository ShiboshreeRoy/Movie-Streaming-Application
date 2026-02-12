import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "prevButton", "nextButton"]
  static values = { currentIndex: Number }
  
  connect() {
    this.currentIndexValue = 0
    this.showCurrentSlide()
    this.updateButtons()
  }
  
  next() {
    this.currentIndexValue = (this.currentIndexValue + 1) % this.slideTargets.length
    this.showCurrentSlide()
    this.updateButtons()
  }
  
  prev() {
    this.currentIndexValue = (this.currentIndexValue - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
    this.updateButtons()
  }
  
  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      if (index === this.currentIndexValue) {
        slide.classList.remove("hidden")
      } else {
        slide.classList.add("hidden")
      }
    })
  }
  
  updateButtons() {
    if (this.hasPrevButtonTarget) {
      this.prevButtonTarget.disabled = this.currentIndexValue === 0
    }
    
    if (this.hasNextButtonTarget) {
      this.nextButtonTarget.disabled = this.currentIndexValue === this.slideTargets.length - 1
    }
  }
  
  goToSlide(event) {
    const slideIndex = parseInt(event.params.index)
    this.currentIndexValue = slideIndex
    this.showCurrentSlide()
    this.updateButtons()
  }
}