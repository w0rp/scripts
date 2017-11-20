/**
 * A script for making pressing Enter in WhatsApp when using other keyboard
 * layouts which break WhatsApp, for some reason.
 */
;(() => {
  const keyListener = (event) => {
    if (event.code === 'Enter' && !event.ctrlKey) {
      const button = document.getElementsByClassName('compose-btn-send')[0]

      if (button != null) {
        button.click()
      }
    }
  }

  const timer = setInterval(() => {
    const textField = document.getElementsByClassName('input-container')[0]

    if (textField != null) {
      textField.removeEventListener('keydown', keyListener)
      textField.addEventListener('keydown', keyListener)
    }
  }, 2000)
})();
