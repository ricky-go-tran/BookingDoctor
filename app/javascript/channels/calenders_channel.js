import consumer from "channels/consumer";

consumer.subscriptions.create("CalendersChannel", {
  connected() {
    console.log("Calendar connecting...");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let calendar = document.getElementById("time-grid");
    let datajson = JSON.parse(calendar.dataset.bookingViews);
    if (data.action == "add") {
      datajson.push(data.data);
      calendar.dataset.bookingViews = JSON.stringify(datajson);
      // console.log(JSON.parse(calendar.dataset.bookingViews));
    }
  },
});
