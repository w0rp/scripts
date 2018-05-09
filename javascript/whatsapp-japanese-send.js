/**
 * A script for making pressing Enter in WhatsApp when using other keyboard
 * layouts which break WhatsApp, for some reason.
 */
;(() => {
  let footer

  const keyListener = (event) => {
    if (event.code === 'Enter' && !event.ctrlKey) {
      // The last button is the send button.
      const buttonList = footer.getElementsByTagName('button')
      const button = buttonList[buttonList.length - 1]

      if (button != null) {
        button.click()
      }
    }
  }

  const timer = setInterval(() => {
    // The footer contains the field for typing in.
    const newFooter = document.getElementsByTagName('footer')[0]

    if (newFooter != null) {
      footer = newFooter

      footer.removeEventListener('keydown', keyListener)
      footer.addEventListener('keydown', keyListener)
    }
  }, 2000)
})();
