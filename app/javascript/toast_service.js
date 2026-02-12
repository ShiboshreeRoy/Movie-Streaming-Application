// Global Toast Service
window.Toast = {
  show(message, type = 'info', options = {}) {
    const defaults = {
      position: 'top-right',
      duration: 5000
    }
    
    const config = { ...defaults, ...options }
    
    // Find or create toast container
    let container = document.querySelector(`[data-controller="toast"][data-toast-position-value="${config.position}"]`)
    
    if (!container) {
      container = document.createElement('div')
      container.setAttribute('data-controller', 'toast')
      container.setAttribute('data-toast-position-value', config.position)
      container.setAttribute('data-toast-duration-value', config.duration)
      document.body.appendChild(container)
    }
    
    // Trigger the appropriate method
    const controller = this.getController(container)
    if (controller) {
      controller[`show${type.charAt(0).toUpperCase() + type.slice(1)}`](message)
    }
  },
  
  success(message, options = {}) {
    this.show(message, 'success', options)
  },
  
  error(message, options = {}) {
    this.show(message, 'error', options)
  },
  
  warning(message, options = {}) {
    this.show(message, 'warning', options)
  },
  
  info(message, options = {}) {
    this.show(message, 'info', options)
  },
  
  getController(element) {
    return window.Stimulus.controllers.find(controller => 
      controller.element === element && controller.identifier === 'toast'
    )
  }
}

// Convenience methods
window.showToast = (message, type = 'info', options = {}) => {
  Toast.show(message, type, options)
}

window.showSuccess = (message, options = {}) => {
  Toast.success(message, options)
}

window.showError = (message, options = {}) => {
  Toast.error(message, options)
}

window.showWarning = (message, options = {}) => {
  Toast.warning(message, options)
}

window.showInfo = (message, options = {}) => {
  Toast.info(message, options)
}