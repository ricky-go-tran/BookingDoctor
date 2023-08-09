import consumer from "channels/consumer"

consumer.subscriptions.create("FinpaysChannel", {
  connected() {
    console.log('Finpays connecting...')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action = 'redirect') {
      window.location.href = `/clinic/workspaces/${data.data}/finish`
    }
  }
});
